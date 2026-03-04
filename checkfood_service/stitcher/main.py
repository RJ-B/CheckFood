"""FastAPI stitching microservice.

Receives a stitch request from Spring Boot, runs OpenCV stitching
in a background task, and POSTs the result back via callback URL.
"""

import logging
import uuid
from pathlib import Path

import httpx
from fastapi import BackgroundTasks, FastAPI
from pydantic import BaseModel

from stitcher import stitch_images

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("stitcher")

app = FastAPI(title="CheckFood Panorama Stitcher", version="1.0.0")

UPLOADS_ROOT = Path("/app/uploads")


class StitchRequest(BaseModel):
    session_id: str
    photo_paths: list[str]
    callback_url: str


class CallbackPayload(BaseModel):
    session_id: str
    status: str  # COMPLETED | FAILED
    result_path: str | None = None
    error_message: str | None = None


@app.get("/health")
def health():
    return {"status": "ok"}


@app.post("/stitch")
async def stitch(request: StitchRequest, background_tasks: BackgroundTasks):
    """Accept stitch request and run in background."""
    logger.info("Stitch request: session=%s, photos=%d", request.session_id, len(request.photo_paths))
    background_tasks.add_task(_run_stitch, request)
    return {"accepted": True, "session_id": request.session_id}


async def _run_stitch(request: StitchRequest):
    """Background stitching task."""
    session_id = request.session_id

    # Resolve paths relative to the shared uploads volume
    absolute_paths: list[str] = []
    for p in request.photo_paths:
        path = Path(p)
        if not path.is_absolute():
            path = UPLOADS_ROOT / p
        absolute_paths.append(str(path))

    output_dir = UPLOADS_ROOT / "panorama" / session_id
    output_file = output_dir / f"{uuid.uuid4().hex}.jpg"

    try:
        result_path = stitch_images(absolute_paths, str(output_file))
        # Convert to relative path for the callback (relative to uploads root)
        relative_path = str(Path(result_path).relative_to(UPLOADS_ROOT))
        payload = CallbackPayload(
            session_id=session_id,
            status="COMPLETED",
            result_path=f"/uploads/{relative_path}",
        )
        logger.info("Stitching completed: session=%s, output=%s", session_id, relative_path)
    except Exception as e:
        error_msg = str(e)[:500]
        payload = CallbackPayload(
            session_id=session_id,
            status="FAILED",
            error_message=error_msg,
        )
        logger.error("Stitching failed: session=%s, error=%s", session_id, error_msg)

    # POST result back to Spring Boot
    try:
        async with httpx.AsyncClient(timeout=10.0) as client:
            resp = await client.post(
                request.callback_url,
                json=payload.model_dump(),
            )
            logger.info("Callback sent: status=%d", resp.status_code)
    except Exception as e:
        logger.error("Callback failed: %s", e)

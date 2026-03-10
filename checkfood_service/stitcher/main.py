"""FastAPI stitching microservice.

Receives a stitch request from Spring Boot, runs OpenCV stitching
in a background task, and POSTs the result back via callback URL.

Supports both local filesystem paths and HTTP URLs (Supabase Storage).
"""

import logging
import os
import tempfile
import uuid
from pathlib import Path

import httpx
from fastapi import BackgroundTasks, FastAPI
from pydantic import BaseModel

from stitcher import stitch_images

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("stitcher")

app = FastAPI(title="CheckFood Panorama Stitcher", version="2.0.0")

UPLOADS_ROOT = Path("/app/uploads")

# Supabase config (from env vars, optional for local dev)
SUPABASE_URL = os.getenv("SUPABASE_URL", "")
SUPABASE_SERVICE_ROLE_KEY = os.getenv("SUPABASE_SERVICE_ROLE_KEY", "")
SUPABASE_STORAGE_BUCKET = os.getenv("SUPABASE_STORAGE_BUCKET", "checkfood-public")


class StitchRequest(BaseModel):
    session_id: str
    photo_urls: list[str]  # Full URLs or local paths
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
    logger.info("Stitch request: session=%s, photos=%d", request.session_id, len(request.photo_urls))
    background_tasks.add_task(_run_stitch, request)
    return {"accepted": True, "session_id": request.session_id}


def _is_http_url(path: str) -> bool:
    """Check if path is an HTTP(S) URL."""
    return path.startswith("http://") or path.startswith("https://")


def _download_photo(url: str, target_path: Path) -> None:
    """Download a photo from HTTP URL to local file."""
    with httpx.Client(timeout=30.0) as client:
        response = client.get(url)
        response.raise_for_status()
        target_path.write_bytes(response.content)


def _upload_to_supabase(file_path: str, object_path: str) -> str:
    """Upload a file to Supabase Storage and return public URL."""
    upload_url = f"{SUPABASE_URL}/storage/v1/object/{SUPABASE_STORAGE_BUCKET}/{object_path}"
    public_url = f"{SUPABASE_URL}/storage/v1/object/public/{SUPABASE_STORAGE_BUCKET}/{object_path}"

    with open(file_path, "rb") as f:
        data = f.read()

    with httpx.Client(timeout=60.0) as client:
        response = client.post(
            upload_url,
            content=data,
            headers={
                "Authorization": f"Bearer {SUPABASE_SERVICE_ROLE_KEY}",
                "apikey": SUPABASE_SERVICE_ROLE_KEY,
                "Content-Type": "image/jpeg",
                "x-upsert": "true",
            },
        )
        response.raise_for_status()

    logger.info("Uploaded to Supabase: %s", object_path)
    return public_url


async def _run_stitch(request: StitchRequest):
    """Background stitching task."""
    session_id = request.session_id
    use_supabase = any(_is_http_url(u) for u in request.photo_urls)

    try:
        if use_supabase:
            # HTTP mode: download photos to temp dir
            with tempfile.TemporaryDirectory(prefix=f"stitch_{session_id}_") as tmpdir:
                local_paths: list[str] = []
                for i, url in enumerate(request.photo_urls):
                    target = Path(tmpdir) / f"photo_{i}.jpg"
                    logger.info("Downloading photo %d: %s", i, url[:100])
                    _download_photo(url, target)
                    local_paths.append(str(target))

                # Stitch
                output_file = str(Path(tmpdir) / f"result_{uuid.uuid4().hex}.jpg")
                stitch_images(local_paths, output_file)

                # Upload result to Supabase
                object_path = f"panorama/{session_id}/result_{uuid.uuid4().hex}.jpg"
                result_url = _upload_to_supabase(output_file, object_path)

            payload = CallbackPayload(
                session_id=session_id,
                status="COMPLETED",
                result_path=result_url,
            )
            logger.info("Stitching completed (Supabase): session=%s", session_id)
        else:
            # Local filesystem mode (Docker volume)
            absolute_paths: list[str] = []
            for p in request.photo_urls:
                path = Path(p)
                if not path.is_absolute():
                    path = UPLOADS_ROOT / p
                absolute_paths.append(str(path))

            output_dir = UPLOADS_ROOT / "panorama" / session_id
            output_file = output_dir / f"{uuid.uuid4().hex}.jpg"

            result_path = stitch_images(absolute_paths, str(output_file))
            relative_path = str(Path(result_path).relative_to(UPLOADS_ROOT))

            payload = CallbackPayload(
                session_id=session_id,
                status="COMPLETED",
                result_path=f"/uploads/{relative_path}",
            )
            logger.info("Stitching completed (local): session=%s, output=%s", session_id, relative_path)

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

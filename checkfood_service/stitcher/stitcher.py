"""Core panorama stitching using OpenCV."""

import cv2
import numpy as np
from pathlib import Path


# cv2.Stitcher status codes
_STATUS_NAMES = {
    cv2.Stitcher_OK: "OK",
    cv2.Stitcher_ERR_NEED_MORE_IMGS: "ERR_NEED_MORE_IMGS",
    cv2.Stitcher_ERR_HOMOGRAPHY_EST_FAIL: "ERR_HOMOGRAPHY_EST_FAIL",
    cv2.Stitcher_ERR_CAMERA_PARAMS_ADJUST_FAIL: "ERR_CAMERA_PARAMS_ADJUST_FAIL",
}


def stitch_images(photo_paths: list[str], output_path: str) -> str:
    """
    Stitch a list of photo file paths into a single panorama.

    Args:
        photo_paths: Absolute paths to input images.
        output_path: Absolute path for the output JPEG.

    Returns:
        The output_path on success.

    Raises:
        FileNotFoundError: If any input image is missing.
        RuntimeError: If stitching fails.
    """
    images: list[np.ndarray] = []
    for p in photo_paths:
        if not Path(p).exists():
            raise FileNotFoundError(f"Image not found: {p}")
        img = cv2.imread(p)
        if img is None:
            raise RuntimeError(f"Failed to read image: {p}")
        images.append(img)

    if len(images) < 2:
        raise RuntimeError(f"Need at least 2 images, got {len(images)}")

    stitcher = cv2.Stitcher.create(cv2.Stitcher_PANORAMA)
    status, panorama = stitcher.stitch(images)

    if status != cv2.Stitcher_OK:
        status_name = _STATUS_NAMES.get(status, f"UNKNOWN({status})")
        raise RuntimeError(f"Stitching failed: {status_name}")

    Path(output_path).parent.mkdir(parents=True, exist_ok=True)
    cv2.imwrite(output_path, panorama, [cv2.IMWRITE_JPEG_QUALITY, 90])

    return output_path

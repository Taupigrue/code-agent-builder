#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="${1:-ghcr.io/taupigrue/openhands-runtime-multilang:latest}"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Building Docker image: ${IMAGE_NAME}..."
docker build -t "${IMAGE_NAME}" -f "${ROOT_DIR}/docker/Dockerfile" "${ROOT_DIR}"
echo "Image ${IMAGE_NAME} built successfully!"

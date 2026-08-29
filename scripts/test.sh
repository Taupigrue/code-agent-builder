#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="${1:-ghcr.io/taupigrue/openhands-runtime-multilang:latest}"

echo "Running environment verification in container: ${IMAGE_NAME}..."
docker run --rm -t "${IMAGE_NAME}" verify-tools

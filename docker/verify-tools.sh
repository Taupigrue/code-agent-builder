#!/usr/bin/env bash
set -euo pipefail

echo "=================================================="
echo "      AI Code Agent Runtime Environment Check     "
echo "=================================================="

check_tool() {
    local name="$1"
    local cmd="$2"
    if command -v "$name" >/dev/null 2>&1; then
        echo -n " [✔] $name: "
        eval "$cmd" | head -n 1
    else
        echo " [✘] $name: NOT FOUND"
        return 1
    fi
}

echo "--- OpenHands & Core Runtimes ---"
check_tool "micromamba" "/openhands/micromamba/bin/micromamba --version"
check_tool "git" "git --version"
check_tool "gh" "gh --version"
check_tool "jq" "jq --version"

echo ""
echo "--- JVM & Kotlin Ecosystem ---"
check_tool "java" "java -version 2>&1"
check_tool "javac" "javac -version"
check_tool "kotlinc" "kotlinc -version"
check_tool "gradle" "gradle --version | grep '^Gradle '"
check_tool "mvn" "mvn --version"

echo ""
echo "--- TypeScript & Node.js Ecosystem ---"
check_tool "node" "node --version"
check_tool "npm" "npm --version"
check_tool "pnpm" "pnpm --version"
check_tool "yarn" "yarn --version"
check_tool "bun" "bun --version"
check_tool "tsc" "tsc --version"
check_tool "tsx" "tsx --version"

echo ""
echo "--- Python Ecosystem ---"
check_tool "python3" "python3 --version"
check_tool "pip" "pip --version"
check_tool "uv" "uv --version"
check_tool "poetry" "poetry --version"
check_tool "pytest" "pytest --version"
check_tool "ruff" "ruff --version"

echo "=================================================="
echo "All toolchains validated successfully!"
echo "=================================================="

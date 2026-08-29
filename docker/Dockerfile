# Base image: Official OpenHands v0.59.0 runtime with Python 3.12 / 3.13 + Node.js 22 + micromamba
FROM ghcr.io/all-hands-ai/runtime:oh_v0.59.0_image_nikolaik_s_python-nodejs_tag_python3.12-nodejs22

LABEL maintainer="Taupigrue"
LABEL description="Multi-language runtime container image for AI code agents (OpenHands, etc.) supporting Java 21, Kotlin, TypeScript, Node.js, Python"
LABEL org.opencontainers.image.source="https://github.com/Taupigrue/code-agent-builder"

USER root
ENV DEBIAN_FRONTEND=noninteractive

# 1. System packages, build tools, utilities, and GitHub CLI repo
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    wget \
    gnupg \
    lsb-release \
    build-essential \
    pkg-config \
    git \
    jq \
    tree \
    unzip \
    zip \
    ripgrep \
    fd-find \
    procps \
    net-tools \
    sudo \
    && mkdir -p -m 755 /etc/apt/keyrings \
    && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update && apt-get install -y --no-install-recommends gh \
    && rm -rf /var/lib/apt/lists/* /tmp/*

# 2. Java 21 OpenJDK and Maven
RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-21-jdk \
    openjdk-21-jre-headless \
    maven \
    && rm -rf /var/lib/apt/lists/* /tmp/*

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH="/openhands/micromamba/bin:${JAVA_HOME}/bin:${PATH}"

# 3. Gradle 8.13 and Kotlin Compiler 2.1.20
ENV GRADLE_VERSION=8.13
ENV KOTLIN_VERSION=2.1.20

RUN wget -q "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -O /tmp/gradle.zip \
    && unzip -q /tmp/gradle.zip -d /opt \
    && ln -s "/opt/gradle-${GRADLE_VERSION}/bin/gradle" /usr/local/bin/gradle \
    && rm /tmp/gradle.zip \
    && wget -q "https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VERSION}/kotlin-compiler-${KOTLIN_VERSION}.zip" -O /tmp/kotlin.zip \
    && unzip -q /tmp/kotlin.zip -d /opt \
    && ln -s /opt/kotlinc/bin/kotlinc /usr/local/bin/kotlinc \
    && ln -s /opt/kotlinc/bin/kotlin /usr/local/bin/kotlin \
    && rm /tmp/kotlin.zip

# 4. TypeScript, JavaScript, pnpm, yarn, bun, tsx
ENV COREPACK_ENABLE_DOWNLOAD_PROMPT=0
RUN npm install -g --force --no-audit --no-fund \
    pnpm@latest \
    typescript@latest \
    ts-node@latest \
    tsx@latest \
    && npm cache clean --force \
    && corepack enable \
    && corepack prepare yarn@stable --activate \
    && curl -fsSL https://bun.sh/install | bash \
    && cp /root/.bun/bin/bun /usr/local/bin/bun

# 5. Python modern tooling: uv, poetry, pytest, ruff, black, mypy
RUN curl -LsSf https://astral.sh/uv/install.sh | env UV_INSTALL_DIR="/usr/local/bin" sh \
    && pip install --no-cache-dir \
    poetry \
    pipx \
    pytest \
    ruff \
    black \
    mypy

# 6. Tool verification script
COPY docker/verify-tools.sh /usr/local/bin/verify-tools
RUN chmod +x /usr/local/bin/verify-tools

WORKDIR /workspace

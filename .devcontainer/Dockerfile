ARG VARIANT=ubuntu-20.04
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    cmake \
    ninja-build

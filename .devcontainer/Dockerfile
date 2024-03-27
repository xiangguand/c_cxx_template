FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gcov \
    ninja-build
RUN mkdir -p /home/workspace
WORKDIR /home/workspace

CMD ["tail", "-f", "/dev/null"]

FROM nvidia/cuda:12.8.1-devel-ubuntu24.04
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y python3 python3-pip && rm -rf /var/lib/apt/lists/*
RUN pip3 install --break-system-packages --no-cache-dir notebook nbconvert ipykernel
WORKDIR /work

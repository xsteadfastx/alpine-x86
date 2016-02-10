FROM 32bit/ubuntu:14.04
RUN apt-get update \
 && apt-get install -y wget \
 && rm -rf /var/lib/apt/lists/*
COPY scripts/mkimage-alpine.sh /
ENTRYPOINT ["/mkimage-alpine.sh"]

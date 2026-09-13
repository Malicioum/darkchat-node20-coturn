FROM ghcr.io/parkervcp/yolks:nodejs_20

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        coturn \
        openssl \
        ca-certificates \
        iproute2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER container

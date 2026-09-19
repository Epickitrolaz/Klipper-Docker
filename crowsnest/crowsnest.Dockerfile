FROM debian:latest

WORKDIR /root

RUN apt-get update \
    && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

RUN cd /root && git clone https://github.com/mainsail-crew/crowsnest.git --depth 1 && cd /root/crowsnest

RUN make install

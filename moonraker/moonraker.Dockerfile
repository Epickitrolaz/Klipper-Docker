FROM debian:latest

WORKDIR /root

RUN apt-get update \
    && apt-get install -y --no-install-recommends python3-virtualenv python3-dev libopenjp2-7 libsodium-dev zlib1g-dev libjpeg-dev packagekit wireless-tools curl build-essential git python3 python3-pip python3-venv iproute2 \
    && rm -rf /var/lib/apt/lists/*

RUN cd /root && git clone https://github.com/Arksine/moonraker.git --depth 1

RUN python3 -m venv /root/moonraker-env && /root/moonraker-env/bin/python3 -m pip install -r /root/moonraker/scripts/moonraker-requirements.txt

RUN mkdir /root/printer_data

EXPOSE 7125

CMD ["/root/moonraker-env/bin/python3", "/root/moonraker/moonraker/moonraker.py", "-d", "/root/printer_data"]

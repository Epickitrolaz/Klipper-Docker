FROM debian:latest

WORKDIR /root

RUN apt-get update \
    && apt-get install -y --no-install-recommends git ca-certificates curl build-essential crudini python3 python3-pip python3-venv pkg-config libevent-dev libjpeg-dev libbsd-dev v4l-utils ustreamer \
    && rm -rf /var/lib/apt/lists/*

RUN cd /root && git clone https://github.com/mainsail-crew/crowsnest --depth 1

RUN cd /root/crowsnest && python3 -m venv --system-site-packages /root/crowsnest-env

RUN /root/crowsnest-env/bin/python -m pip install --no-cache-dir -r /root/crowsnest/requirements.txt

RUN mkdir /root/printer_data /var/log/crowsnest

WORKDIR /root/crowsnest

EXPOSE 8080 8081 8082 8083

CMD ["/root/crowsnest-env/bin/python3", "-m", "crowsnest", "-c", "/root/printer_data/config/crowsnest.conf", "-l", "/var/log/crowsnest/crowsnest.log", "-s", "5"]

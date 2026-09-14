FROM nginx:latest

RUN apt-get update \
    && apt-get install -y --no-install-recommends unzip wget \
    && rm -rf /var/lib/apt/lists/*

# Remove the official image's default virtual host
RUN rm -f /etc/nginx/conf.d/default.conf

# This must be a .conf file inside conf.d
COPY ./nginx/conf.d/common_vars.conf /etc/nginx/conf.d/common_vars.conf
COPY ./nginx/conf.d/upstreams.conf /etc/nginx/conf.d/upstreams.conf
COPY ./nginx/mainsail /etc/nginx/conf.d/mainsail.conf

RUN rm -rf /usr/share/nginx/html/* \
    && wget -q -O /tmp/mainsail.zip \
       https://github.com/mainsail-crew/mainsail/releases/latest/download/mainsail.zip \
    && unzip -oq /tmp/mainsail.zip -d /usr/share/nginx/html \
    && rm -f /tmp/mainsail.zip \
    && test -f /usr/share/nginx/html/index.html

RUN nginx -t

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

FROM nginx

WORKDIR /root

RUN apt update && apt install git unzip wget -y && rm -rf /var/lib/apt/lists/*

COPY ./nginx/conf.d/upstreams.conf /etc/nginx/conf.d/upstreams.conf
COPY ./nginx/conf.d/common_vars.conf /etc/nginx/conf.d/common_vars.conf
COPY ./nginx/mainsail /etc/nginx/sites-available/mainsail

RUN mkdir -p /root/mainsail
RUN rm -f /etc/nginx/sites-enabled/default
RUN rm -f /etc/nginx/conf.d/default.conf

RUN mkdir -p /etc/nginx/sites-enabled/
RUN ln -s /etc/nginx/sites-available/mainsail /etc/nginx/sites-enabled/

RUN wget -q -O mainsail.zip https://github.com/mainsail-crew/mainsail/releases/latest/download/mainsail.zip && unzip mainsail.zip -d /root/mainsail/ && rm mainsail.zip

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

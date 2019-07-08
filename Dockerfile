FROM nextcloud:latest

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    imagemagick \
    supervisor \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /var/log/supervisord /var/run/supervisord

COPY supervisord.conf /etc/supervisor/supervisord.conf

CMD ["/usr/bin/supervisord"]

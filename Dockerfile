FROM nextcloud:latest

COPY version.sh /root/
RUN chmod +x /root/version.sh \
    && /root/version.sh

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    imagemagick \
    supervisor \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /var/log/supervisord /var/run/supervisord

COPY supervisord.conf /etc/supervisor/supervisord.conf

ENV NEXTCLOUD_UPDATE=1

CMD ["/usr/bin/supervisord"]

FROM nextcloud::apache

COPY version /root/
RUN chmod +x /root/version \
    && /root/version -l

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    imagemagick \
    supervisor \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /var/log/supervisord /var/run/supervisord

COPY supervisord.conf /etc/supervisor/supervisord.conf

ENV NEXTCLOUD_UPDATE=1

RUN /root/version -i

CMD ["/usr/bin/supervisord"]

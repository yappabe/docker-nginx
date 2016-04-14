FROM debian:jessie

MAINTAINER Joeri Verdeyen <joeriv@yappa.be>

ENV PHP_FPM_SOCKET "php:9000"
ENV DOCUMENT_ROOT /var/www/app/web
ENV INDEX_FILE app_dev.php

RUN apt-get update && \
    apt-get install -y nginx && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists && \
    echo Europe/Brussels > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata


COPY ssl/dummy.crt  /etc/ssl/crt/dummy.crt
COPY ssl/dummy.key  /etc/ssl/crt/dummy.key
COPY nginx.conf /etc/nginx/
COPY default.conf /etc/nginx/sites-available/
COPY default-ssl.conf /etc/nginx/sites-available/

RUN ln -sf /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default && \
    ln -sf /etc/nginx/sites-available/default-ssl.conf /etc/nginx/sites-enabled/default-ssl && \
    usermod -u 1000 www-data && \
    ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80
EXPOSE 443

COPY run.sh run.sh

ENTRYPOINT ["/bin/bash", "/run.sh"]

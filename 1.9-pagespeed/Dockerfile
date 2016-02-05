FROM debian:jessie

MAINTAINER Joeri Verdeyen <joeriv@yappa.be>

ENV PHP_FPM_SOCKET "php:9000"
ENV DOCUMENT_ROOT /var/www/app/web
ENV INDEX_FILE app_dev.php

ENV NPS_VERSION 1.9.32.10
ENV NGINX_VERSION 1.9.6
ENV OPENSSL_VERSION 1.0.2d
ENV BUILDDIR /b

RUN echo deb http://http.debian.net/debian jessie-backports main >> /etc/apt/sources.list && \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get -y install -t jessie-backports wget unzip build-essential zlib1g-dev libpcre3 libpcre3-dev && \
    mkdir ${BUILDDIR} && cd ${BUILDDIR} && \
    wget https://github.com/pagespeed/ngx_pagespeed/archive/release-${NPS_VERSION}-beta.zip && \
    unzip release-${NPS_VERSION}-beta.zip && \
    cd ngx_pagespeed-release-${NPS_VERSION}-beta/ && \
    wget https://dl.google.com/dl/page-speed/psol/${NPS_VERSION}.tar.gz && \
    tar -xzvf ${NPS_VERSION}.tar.gz && \
    cd ${BUILDDIR} && \
    wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
    tar -xvzf nginx-${NGINX_VERSION}.tar.gz && \
    cd ${BUILDDIR} && \
    wget http://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz && \
    tar -xvzf openssl-${OPENSSL_VERSION}.tar.gz && \
    cd ${BUILDDIR}/nginx-${NGINX_VERSION} && \
    ./configure \
        --add-module=${BUILDDIR}/ngx_pagespeed-release-${NPS_VERSION}-beta/ \
        --with-openssl=${BUILDDIR}/openssl-${OPENSSL_VERSION} \
        --prefix=/etc/nginx \
        --sbin-path=/usr/sbin/nginx \
        --conf-path=/etc/nginx/nginx.conf \
        --error-log-path=/var/log/nginx/error.log \
        --http-log-path=/var/log/nginx/access.log \
        --pid-path=/var/run/nginx.pid \
        --lock-path=/var/run/nginx.lock \
        --with-http_ssl_module \
        --with-http_realip_module \
        --with-http_addition_module \
        --with-http_sub_module \
        --with-http_dav_module \
        --with-http_flv_module \
        --with-http_mp4_module \
        --with-http_gunzip_module \
        --with-http_gzip_static_module \
        --with-http_random_index_module \
        --with-http_secure_link_module \
        --with-http_stub_status_module \
        --with-mail \
        --with-mail_ssl_module \
        --with-file-aio && \
    make && make install && \
    cd / && \
    rm -r ${BUILDDIR} && \
    apt-get purge -y --auto-remove wget build-essential unzip && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /ngx_pagespeed_cache && chmod -R 777 /ngx_pagespeed_cache  && \
    echo Europe/Brussels > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata

COPY nginx.conf /etc/nginx/
COPY default.conf /etc/nginx/sites-available/

RUN mkdir -p /etc/nginx/sites-enabled && \
    mkdir -p /etc/nginx/conf.d/ && \
    touch /etc/nginx/conf.d/upstream.conf && \
    ln -sf /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default && \
    usermod -u 1000 www-data && \
    ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80
EXPOSE 443

COPY run.sh /run.sh

ENTRYPOINT ["/bin/bash", "/run.sh"]

![Docker pulls](https://img.shields.io/docker/pulls/yappabe/nginx.svg?style=flat)
# Yappa Nginx Docker Image

## Usage

Add the following to your docker-compose.yml file:

```YAML
nginx:
    image: yappabe/nginx
    ports:
        - 80:80
    links:
        - php
    volumes_from:
        - app
    environment:
        DOCUMENT_ROOT: /var/www/app/html
        INDEX_FILE: app_dev.php
        PHP_FPM_SOCKET: php:9000

```

## ENV vars

* DOCUMENT_ROOT defaults to /var/www/app/html
* INDEX_FILE defaults to app_dev.php
* PHP_FPM_SOCKET defaults to php:9000

## Nginx Versions

To use a specific Nginx version, append the version number to the image name.

Eg: `image: yappabe/nginx:1.9`

The following Nginx versions are available:

* Nginx 1.6 (jessie stable)
* Nginx 1.9 (jessie backports)

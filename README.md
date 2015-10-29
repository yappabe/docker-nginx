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

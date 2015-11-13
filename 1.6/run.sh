#!/bin/bash
echo "upstream php-upstream { server $PHP_FPM_SOCKET; }" > /etc/nginx/conf.d/upstream.conf && \
sed -i "s|DOCUMENT_ROOT|$DOCUMENT_ROOT|g" /etc/nginx/sites-enabled/default && \
sed -i "s|INDEX_FILE|$INDEX_FILE|g" /etc/nginx/sites-enabled/default && \
nginx
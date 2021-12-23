#!/bin/sh
# e.g. https://onboarding.anaml.io
ROOT_URL=$1
REBRAND=${REBRAND:-Anaml}

echo "ROOT_URL=$ROOT_URL"
echo "REBRAND=$REBRAND"

if [ "$ROOT_URL" != "" ]
then
  grep -rl http://localhost:8000 /usr/share/nginx/anaml | xargs sed -i "s#http://localhost:8000#$ROOT_URL#g"
fi

if [ "$REBRAND" != "" ]
then
  grep -rl "PRODUCT_NAME" /usr/share/nginx/anaml | xargs sed -i "s#PRODUCT_NAME#$REBRAND#g"
fi

[ -r /certificates/tls.key -a -r /certificates/tls.crt ] || rm -f /etc/nginx/conf.d/nginx-ssl.conf

nginx -g "daemon off;"

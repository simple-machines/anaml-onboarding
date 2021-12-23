### This is the build container
FROM python:3.9
ARG CONFIG_FILE=mkdocs.yml

RUN apt-get update -qq
RUN apt-get upgrade -y

RUN pip3 install mkdocs mkdocs-material mkdocstrings

# anaml-sdk dependencies - be better if we pip installed anaml-sdk
RUN pip3 install pandas jsonschema requests matplotlib numpy scipy seaborn isodate

RUN mkdocs new anaml

COPY ${CONFIG_FILE} /anaml
RUN mkdir -p /anaml/docs
ADD docs/ /anaml/docs

COPY anaml-python-sdk/src /python-client

WORKDIR /anaml
ENV PYTHONPATH=/python-client
RUN  mkdocs build -f ${CONFIG_FILE} -d site/docs
RUN sed -i "s#href=\"\/#href=\"/docs/#g" site/docs/404.html

### Build the final container
FROM nginx:alpine

RUN mkdir -p /usr/share/nginx/anaml
COPY --from=0 /anaml /usr/share/nginx/anaml
RUN rm -f /etc/nginx/conf.d/*
COPY nginx.conf /etc/nginx/conf.d
COPY nginx-ssl.conf /etc/nginx/conf.d
COPY docker-entrypoint.sh /
RUN sed -i "s|#gzip  on;|gzip  on; etag  off; server_tokens off; gzip_types *;|" /etc/nginx/nginx.conf

CMD ["http://localhost:8000"]
ENTRYPOINT ["/docker-entrypoint.sh"]

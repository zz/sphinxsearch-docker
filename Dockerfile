# Dockerfile for Sphinx SE
# https://hub.docker.com/_/alpine/
FROM alpine:3.12

# https://sphinxsearch.com/blog/
ENV SPHINX_VERSION 3.2.1-f152e0b
ENV PATH "${PATH}:/opt/sphinx/bin"

# install dependencies
RUN apk add --no-cache mariadb-connector-c-dev \
	postgresql-dev \
	curl && \
    mkdir -pv /opt/sphinx/log /opt/sphinx/index && \
    curl -SL http://sphinxsearch.com/files/sphinx-${SPHINX_VERSION}-linux-amd64-musl.tar.gz | \
    tar -zxf - --strip-components=1 -C /opt/sphinx && \
    ln -sv /dev/stdout /opt/sphinx/log/query.log && \
    ln -sv /dev/stdout /opt/sphinx/log/searchd.log

# expose TCP port
EXPOSE 36307

VOLUME /opt/sphinx/index
VOLUME /opt/sphinx/conf

CMD searchd --nodetach --config /opt/sphinx/conf/sphinx.conf

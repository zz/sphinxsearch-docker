#!/bin/sh
set -e

if [ "${1#-}" != "$1" ]; then
    set -- searchd "$@"
fi

echo "Sphinxsearch docker command first param: $1"

if [ "$1" = 'searchd' ]; then
    # If the sphinx config exists, try to run the indexer before starting searchd
    if [ -f /opt/sphinx/conf/sphinx.conf ]; then
        echo "starting sphinxsearch indexer ..."
        indexer --all --config /opt/sphinx/conf/sphinx.conf
    fi
fi

exec "$@"

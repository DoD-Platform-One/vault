#!/bin/bash
set -ex
# stall the ensure that the instances are started.
sleep 60
mc config host add bigbang ${MINIO_HOST}:${MINIO_PORT} ${ACCESS_KEY} ${SECRET_KEY}
# cleanup from pervious runs
mc rb bigbang/foobar --force || true 
mc mb bigbang/foobar
mc ls bigbang/foobar
base64 /dev/urandom | head -c 10000000 > /tmp/file.txt
md5sum /tmp/file.txt > /tmp/filesig
mc cp /tmp/file.txt bigbang/foobar/file.txt
mc ls bigbang/foobar/file.txt
mc cp bigbang/foobar/file.txt /tmp/file.txt
mc rb bigbang/foobar --force
md5sum -c /tmp/filesig

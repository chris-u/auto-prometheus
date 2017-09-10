#!/bin/sh

test -n "${CONFIG_URL}" &&
(
  while 
    sleep ${CONFIG_CHECK_INTERVAL:=30}
  do
    /usr/bin/curl -s -L  ${CONFIG_URL} > /etc/prometheus/file_ad.yml
  done
) &

bg_pid=$!

/prometheus-1.7.1.linux-amd64/prometheus \
  -config.file=/etc/prometheus/prometheus.yml \
  -storage.local.path=/prometheus \
  -alertmanager.url=${PROMETHEUS_ALERTMANAGER_URL}

kill -9 $bg_pid

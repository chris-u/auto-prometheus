FROM alpine
LABEL maintainer "chris ulrich <culrich@athenahealth.com>"

ENV PROMETHEUS_ALERTMANAGER_URL http://localhost:9093

EXPOSE     9090

VOLUME     [ "/prometheus" ]

WORKDIR    /prometheus

COPY configs/prometheus.yml /etc/prometheus/prometheus.yml
COPY scripts/prometheus-entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh && \
    apk --no-cache add curl && \
    cd / && \
    curl -s -L https://github.com/prometheus/prometheus/releases/download/v1.7.1/prometheus-1.7.1.linux-amd64.tar.gz  | gzip -d | tar -xf -

ENTRYPOINT [ "/entrypoint.sh" ]

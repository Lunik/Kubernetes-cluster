FROM alpine:latest
MAINTAINER Guillaume Martinez <guillaume.martinez@cc.exemple.fr>

RUN apk --update --no-cache add haproxy

ADD config/haproxy.cfg /etc/haproxy/haproxy.cfg

EXPOSE 2222

CMD ["haproxy", "-d", "-f", "/etc/haproxy/haproxy.cfg"]

FROM alpine:latest
MAINTAINER Guillaume Martinez <guillaume.martinez@cc.exemple.fr>

RUN apk --update --no-cache add nginx && \
    mkdir /run/nginx && \
    touch /run/nginx/nginx.pid

ADD config/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

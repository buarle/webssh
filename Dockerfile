FROM alpine:3.11

ENV TZ=Europe/Berlin

RUN sed -i 's/http\:\/\/dl-cdn.alpinelinux.org/https\:\/\/mirror1.hs-esslingen.de\/pub\/Mirrors/g' /etc/apk/repositories && \
    apk upgrade --no-cache && \
    apk add --no-cache --virtual=build-dependencies make gcc libffi-dev musl-dev openssl-dev python3-dev && \
    apk add --no-cache python3 tzdata && \
    pip3 install --upgrade pip && \
    pip3 install webssh && \
    apk del build-dependencies && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

EXPOSE 8888

ENTRYPOINT ["wssh", "--address=0.0.0.0", "--port=8888"]

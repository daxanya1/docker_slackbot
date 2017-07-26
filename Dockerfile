FROM golang AS build-env
RUN CGO_ENABLED=0 go get github.com/okzk/env-injector

FROM alpine:3.6
RUN apk --no-cache update && \
    apk add --no-cache python3 && \
    apk add --no-cache ca-certificates && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    rm -r /root/.cache && \
    rm -rf /var/cache/apk/* && \
    pip3 install slackbot && \
    mkdir -p /opt/slackbot/plugins
# for DEBUG
# RUN apk --no-cache add python curl groff less && \
#     pip --no-cache-dir install awscli && \
#     rm -rf /var/cache/apk/*
COPY --from=build-env /go/bin/env-injector /usr/local/bin/
ENTRYPOINT ["env-injector"]
COPY ./run.py /opt/slackbot/
COPY ./slackbot_settings.py /opt/slackbot/
COPY ./plugins/* /opt/slackbot/plugins/
ENV API_TOKEN=

CMD ["python3","/opt/slackbot/run.py"]

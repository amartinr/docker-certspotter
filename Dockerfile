ARG GO_VERSION=alpine

# Go builder

FROM golang:${GO_VERSION} AS builder

RUN go install software.sslmate.com/src/certspotter/cmd/certspotter@latest

# Final image

FROM alpine:latest


RUN apk update && apk add shadow

RUN mkdir /certspotter/ && \
  cd /certspotter && \
  mkdir .certspotter bin base-hooks.d && \
  usermod --home /certspotter nobody

COPY --from=builder /go/bin/certspotter /certspotter/bin/certspotter

COPY docker-entrypoint.sh /certspotter/bin/docker-entrypoint.sh
COPY base-hooks.d/* /certspotter/base-hooks.d/
COPY utils.sh /certspotter/
COPY notify.sh /certspotter/bin/notify.sh
RUN chmod -R +x /certspotter/bin/docker-entrypoint.sh /certspotter/bin/notify.sh /certspotter/bin/certspotter /certspotter/base-hooks.d/
RUN chown -R 65534:65534 /certspotter

USER nobody:nogroup

ENTRYPOINT ["/certspotter/bin/docker-entrypoint.sh"]

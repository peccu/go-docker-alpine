FROM golang:1.8 AS go
MAINTAINER peccu <peccul@gmail.com>

COPY ./main.go /go/src/hello-world/main.go
RUN set -x ; \
  cd $GOPATH/src/hello-world \
  && go build

FROM alpine:latest
COPY --from=go /go/src/hello-world/hello-world /hello-world
CMD ["/hello-world"]

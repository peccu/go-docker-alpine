# go-docker-alpine
Docker's multi stage build from golfing to alpine example.

# Dockerfile

```
FROM golang:1.8 AS go
MAINTAINER peccu <peccul@gmail.com>

COPY ./main.go /go/src/hello-world/main.go
RUN set -x ; \
  cd $GOPATH/src/hello-world \
  && go build

FROM alpine:latest
COPY --from=go /go/src/hello-world/hello-world /hello-world
CMD ["/hello-world"]
```

# Build example
```
$ docker build -t tag-name:latest .
$ docker run --rm -it tag-name:latest
Hello, World!
```

# Comparison

- no multi-stage
```
FROM golang:1.8 AS go
MAINTAINER peccu <peccul@gmail.com>

COPY ./main.go /go/src/hello-world/main.go
RUN set -x ; \
  cd $GOPATH/src/hello-world \
  && go build
CMD ["/go/src/hello-world/hello-world"]
```

```
$ docker build -t tag-name:no-multistage .
```

- with multi-stage
```
FROM golang:1.8 AS go
MAINTAINER peccu <peccul@gmail.com>

COPY ./main.go /go/src/hello-world/main.go
RUN set -x ; \
  cd $GOPATH/src/hello-world \
  && go build

FROM alpine:latest
COPY --from=go /go/src/hello-world/hello-world /hello-world
CMD ["/hello-world"]
```

```
$ docker build -t tag-name:latest .
```

- image sizes

```
$ docker images tag-name
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
tag-name            no-multi            eb60933115c3        8 minutes ago       715MB
tag-name            latest              3ee4098b1948        17 minutes ago      5.7MB
```

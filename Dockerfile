FROM golang:1.16.5-alpine

WORKDIR /
ENV PROTOBUF_VER=3.14.0
ENV GOPROXY=https://proxy.golang.org
RUN apk update && \
  apk add --no-cache git build-base autoconf automake libtool tar gzip curl

RUN curl -L -o protoc.tar.gz https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOBUF_VER}/protobuf-cpp-${PROTOBUF_VER}.tar.gz \
  && tar xvzf protoc.tar.gz \
  && cd protobuf-${PROTOBUF_VER} \
  && ./autogen.sh \
  && ./configure --disable-dependency-tracking \
  && make -j 4 \
  && make install

RUN apk del build-base autoconf automake libtool

RUN go get -u google.golang.org/protobuf/cmd/protoc-gen-go


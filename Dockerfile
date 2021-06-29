FROM golang:1.16.5-alpine

WORKDIR /

ENV PROTOBUF_VER=3.17.3
ADD https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOBUF_VER}/protobuf-cpp-${PROTOBUF_VER}.tar.gz .

RUN apk update && \
  apk add --no-cache autoconf automake libtool curl make g++ unzip git curl

RUN tar xvzf protobuf-cpp-${PROTOBUF_VER}.tar.gz \
  && cd protobuf-${PROTOBUF_VER} \
  && ./autogen.sh \
  && ./configure \
  && make \
  && make install

RUN apk del autoconf automake libtool curl make g++ unzip

ENV GOPROXY=https://proxy.golang.org
RUN go get -u google.golang.org/protobuf/cmd/protoc-gen-go


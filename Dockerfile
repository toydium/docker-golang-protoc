FROM golang:1.17.1-alpine

WORKDIR /

RUN apk update && apk add git build-base autoconf automake libtool tar gzip curl

ENV PROTOBUF_VER=3.17.3
RUN curl -L -o protoc.tar.gz https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOBUF_VER}/protobuf-cpp-${PROTOBUF_VER}.tar.gz
RUN tar xvzf protoc.tar.gz
RUN cd protobuf-${PROTOBUF_VER} && ./autogen.sh && ./configure && make -j 4 && make install

ENV GOPROXY=https://proxy.golang.org
RUN go get -u google.golang.org/protobuf/cmd/protoc-gen-go


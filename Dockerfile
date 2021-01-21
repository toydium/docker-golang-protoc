FROM golang:1.15.7-buster

WORKDIR /

RUN apt-get update && apt-get install -y libtool unzip wget

ENV PROTOBUF_VER=3.14.0
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOBUF_VER}/protoc-${PROTOBUF_VER}-linux-x86_64.zip \
    && unzip protoc-${PROTOBUF_VER}-linux-x86_64.zip -d protoc \
    && mv ./protoc/bin/protoc /usr/local/bin/ \
    && mv ./protoc/include/* /usr/local/include/ \
    && rm -rf ./protoc

ENV GOPROXY=https://proxy.golang.org
RUN go get -u google.golang.org/protobuf/cmd/protoc-gen-go


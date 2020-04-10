FROM golang:1.14.2-buster

WORKDIR /

RUN apt-get update && apt-get install -y libtool unzip wget

ENV PROTOBUF_VER=3.11.4
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOBUF_VER}/protoc-${PROTOBUF_VER}-linux-x86_64.zip \
    && unzip protoc-${PROTOBUF_VER}-linux-x86_64.zip -d protoc \
    && mv ./protoc/bin/protoc /usr/local/bin/ \
    && mv ./protoc/include/* /usr/local/include/ \
    && rm -rf ./protoc

ENV GOPROXY=https://proxy.golang.org
RUN go get -u github.com/golang/protobuf/proto
RUN go get -u github.com/golang/protobuf/protoc-gen-go


FROM golang:1.17.1-bullseye

WORKDIR /

ENV PROTOC_VERSION=3.17.3
ADD https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-x86_64.zip ./

RUN apt-get -q -y update && \
  apt-get -q -y install unzip && \
  unzip protoc-${PROTOC_VERSION}-linux-x86_64.zip -d ./usr/local && \
  apt-get remove -y unzip

ENV GOPROXY=https://proxy.golang.org
RUN go get -u google.golang.org/protobuf/cmd/protoc-gen-go


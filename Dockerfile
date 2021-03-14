FROM golang:alpine3.13

ENV IPFS_VERSION=0.8.0
ENV IPFS_SRC_PATH=/go/src/github.com/ipfs/go-ipfs

RUN apk add --no-cache git make bash gcc musl-dev libc6-compat                                              \
    && git clone --branch v${IPFS_VERSION} --depth=1 https://github.com/ipfs/go-ipfs.git ${IPFS_SRC_PATH}   \
    && cd ${IPFS_SRC_PATH}                                                                                  \
    && make build                                                                                           \
    && mv ${IPFS_SRC_PATH}/cmd/ipfs/ipfs /bin/ipfs



FROM alpine:latest
MAINTAINER AooJ <aooj@n13.cz>

ENV IPFS_PATH=/opt/ipfs

RUN apk update && apk upgrade --no-cache && apk add --no-cache libc6-compat
COPY --from=0 /bin/ipfs /bin/ipfs
ADD start-ipfs.sh /bin/start-ipfs
RUN chmod +x /bin/start-ipfs

EXPOSE 4001/tcp 4001/udp 5001/tcp 8080/tcp
WORKDIR ${IPFS_PATH}
VOLUME ${IPFS_PATH}

ENTRYPOINT ["/bin/start-ipfs"]
CMD []

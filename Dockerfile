FROM centos:centos8
MAINTAINER AooJ <aooj@n13.cz>

ENV IPFS_VERSION=0.8.0
ENV IPFS_BIN_SHA256=abb3ee016419e12b637d611750859f67238b99ad4a23584538472e237324024a
ENV IPFS_PATH=/opt/ipfs

RUN yum update -y && yum clean all && rm -rf /var/cache/yum                                                 \
    && curl -L https://dist.ipfs.io/go-ipfs/v${IPFS_VERSION}/go-ipfs_v${IPFS_VERSION}_linux-amd64.tar.gz    \
    | tar -C /bin --strip-component=1 -zx go-ipfs/ipfs                                                      \
    && echo "${IPFS_BIN_SHA256}  /bin/ipfs" --check --status                                                \
    && ipfs --version

ADD start-ipfs.sh /bin/start-ipfs
RUN chmod +x /bin/start-ipfs

EXPOSE 4001/tcp 4001/udp 5001/tcp 8080/tcp
WORKDIR ${IPFS_PATH}
VOLUME ${IPFS_PATH}

ENTRYPOINT ["/bin/start-ipfs"]
CMD []

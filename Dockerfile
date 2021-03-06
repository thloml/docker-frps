FROM alpine:3.12.1
MAINTAINER zhang@gmail.com

ARG frps_version
ARG arch=amd64
ENV frps_version=${frps_version:-0.34.3} \
    frps_DIR=/usr/local/frps \
    arch=${arch:-amd64}
    
RUN set -ex && \
    frps_latest=https://github.com/fatedier/frp/releases/download/v${frps_version}/frp_${frps_version}_linux_${arch}.tar.gz && \
    frps_latest_filename=frp_${frps_version}_linux_${arch}.tar.gz && \
    apk add --no-cache  --virtual wget tar && \
    [ ! -d ${frps_DIR} ] && mkdir -p ${frps_DIR} && cd ${frps_DIR} && \
    wget -q  ${frps_latest} -O ${frps_latest_filename} && \
    tar -xzf ${frps_latest_filename} && \
    mv frp_${frps_version}_linux_${arch}/frps ${frps_DIR}/frps && \
    rm -rf /var/cache/apk/* ~/.cache ${frps_DIR}/${frps_latest_filename} ${frps_DIR}/frp_${frps_version}_linux_${arch}

VOLUME /conf

ENTRYPOINT ["/usr/local/frps/frps", "-c", "/conf/frps.ini"]

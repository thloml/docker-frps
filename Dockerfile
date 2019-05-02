FROM alpine:latest
MAINTAINER zhang@gmail.com


ENV frps_version=0.27.0 \
    frps_DIR=/usr/local/frps \
    arch=amd64

RUN set -ex && \
    frps_latest=https://github.com/fatedier/frp/releases/download/v${frps_version}/frp_${frps_version}_linux_${arch}.tar.gz && \
    frps_latest_filename=frp_${frps_version}_linux_${arch}.tar.gz && \
    apk add --no-cache pcre bash && \
    apk add --no-cache  --virtual TMP wget tar && \
    [ ! -d ${frps_DIR} ] && mkdir -p ${frps_DIR} && cd ${frps_DIR} && \
    wget --no-check-certificate -q ${frps_latest} -O ${frps_latest_filename} && \
    tar xzf ${frps_latest_filename} && \
    mv frp_${frps_version}_linux_${arch}/frps ${frps_DIR}/frps && \
    apk --no-cache del --virtual TMP && \
    rm -rf /var/cache/apk/* ~/.cache ${frps_DIR}/${frps_latest_filename} ${frps_DIR}/frp_${frps_version}_linux_${arch}

VOLUME /conf

ENTRYPOINT ["/usr/local/frps/frps", "-c", "/conf/frps.ini"]

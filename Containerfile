
FROM redhat/ubi9:latest AS builder
ARG COW_VER=2.0.4
RUN curl -sL https://github.com/Code-Hex/Neo-cowsay/releases/download/v${COW_VER}/cowsay_${COW_VER}_Linux_x86_64.tar.gz | tar zxf -

FROM redhat/ubi9-micro:latest
COPY --from=builder cowsay cowthink /usr/bin

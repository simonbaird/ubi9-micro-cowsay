
FROM docker.io/redhat/ubi9:latest@sha256:dec374e05cc13ebbc0975c9f521f3db6942d27f8ccdf06b180160490eef8bdbc AS builder
ARG COW_VER=2.0.4
RUN curl -sL https://github.com/Code-Hex/Neo-cowsay/releases/download/v${COW_VER}/cowsay_${COW_VER}_Linux_x86_64.tar.gz | tar zxf -

FROM docker.io/redhat/ubi9-micro:latest@sha256:aff810919642215e15c993b9bbc110dbcc446608730ad24499dafd9df7a8f8f4
COPY --from=builder cowsay cowthink /usr/bin

ENTRYPOINT ["/usr/bin/cowsay"]
CMD ["Kowflux?"]

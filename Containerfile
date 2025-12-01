
# Build stage
FROM docker.io/redhat/ubi9:latest@sha256:dec374e05cc13ebbc0975c9f521f3db6942d27f8ccdf06b180160490eef8bdbc AS builder

WORKDIR /cowsay
ARG COW_VER=2.0.4
RUN curl -sL https://github.com/Code-Hex/Neo-cowsay/releases/download/v${COW_VER}/cowsay_${COW_VER}_Linux_x86_64.tar.gz | \
  tar zxf -

WORKDIR /lolcat
ARG LOLCAT_VER=acb30b7e1f91437672ac784ad2a2b407cfb382c9
RUN dnf install -y git-core gcc && \
  git clone https://github.com/jaseg/lolcat.git --single-branch --depth 1 . && \
  git checkout ${LOLCAT_VER} && \
  make

WORKDIR /lolcow
RUN cat <<'EOT' > lolcow && chmod 755 lolcow
#!/bin/bash
cowsay "${*:-Kowflux..?}" | lolcat -f -h 0.8 -v 1
EOT

# Final image
FROM docker.io/redhat/ubi9-micro:latest@sha256:aff810919642215e15c993b9bbc110dbcc446608730ad24499dafd9df7a8f8f4
COPY --from=builder /cowsay/cowsay /cowsay/cowthink /lolcat/lolcat /lolcow/lolcow /usr/bin/

ENTRYPOINT ["/usr/bin/lolcow"]

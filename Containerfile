
# Build stage
# https://hub.docker.com/r/redhat/ubi9
FROM docker.io/redhat/ubi9:latest@sha256:c5cc9c221baa8eb13093f90c31bb58c04d83f6afd14510d3496691f92566f99e AS builder

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
cowsay "${*:-Kowflux...?}" | lolcat -f -h 0.8 -v 1
EOT

# Final image
# https://hub.docker.com/r/redhat/ubi9-micro
FROM docker.io/redhat/ubi9-micro:latest@sha256:e9765516d74cafded50d8ef593331eeca2ef6eababdda118e5297898d99b7433
COPY --from=builder /cowsay/cowsay /cowsay/cowthink /lolcat/lolcat /lolcow/lolcow /usr/bin/

ENTRYPOINT ["/usr/bin/lolcow"]

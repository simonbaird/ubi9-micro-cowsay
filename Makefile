
COW_VER=2.0.4
REPO=quay.io/sbaird/ubi9-micro-cowsay

build:
	podman build --build-arg COW_VER=$(COW_VER) --tag $(REPO):latest .

push:
	podman push $(REPO):latest

run:
	podman run --rm $(REPO) cowsay hello

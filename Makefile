
COW_VER=2.0.4
IMAGE_REPO=quay.io/sbaird/ubi9-micro-cowsay
BUNDLE_REPO=quay.io/sbaird/tkn-cowsay

build:
	podman build --build-arg COW_VER=$(COW_VER) --tag $(IMAGE_REPO):latest .

push:
	podman push $(IMAGE_REPO):latest

tkn-bundle:
	tkn bundle push $(BUNDLE_REPO):latest -f tasks/cowsay.yaml

run:
	podman run --rm $(IMAGE_REPO) cowsay hello

update: build push tkn-bundle

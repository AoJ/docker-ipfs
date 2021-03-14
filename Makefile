NAME ?= ipfs
VERSION ?= latest
pwd = $(shell pwd)

image:
	docker build -f Dockerfile \
	--no-cache \
	--rm \
	-t ${NAME}:${VERSION} \
	.

.PHONY: image

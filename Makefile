TAG ?= dev
PROJECT ?= darkability/freenet
IMAGE = $(PROJECT):$(TAG)
MOUNT_DIR ?= $(PWD)/mount
ACCESS_MODE ?= open
OUTPUT_BANDWIDTH ?= 56000
INPUT_BANDWIDTH ?= 56000
STORE_SIZE ?= 512000000

.PHONY: build run shell push

build:
	docker build --rm -t $(IMAGE) docker

run:
	mkdir -p $(MOUNT_DIR) && \
	docker run --rm -it \
		--net=host \
		-p 8888:8888 \
		-p 9481:9481 \
		-p 28585:28585 \
		-p 60332:60332 \
		-e "ACCESS_MODE=$(ACCESS_MODE)" \
		-e "OUTPUT_BANDWIDTH=$(OUTPUT_BANDWIDTH)" \
		-e "INPUT_BANDWIDTH=$(INPUT_BANDWIDTH)" \
		-e "STORE_SIZE=$(STORE_SIZE)" \
		-v $(MOUNT_DIR):/opt/freenet/mount \
		-v /dev/urandom:/dev/random \
		$(IMAGE)

shell:
	docker run --rm -it $(IMAGE) bash

push:
	docker push $(IMAGE)

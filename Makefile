USERNAME = darkability
NAME = freenet
IMAGE = $(USERNAME)/$(NAME):$(TAG)

TAG ?= 1470
ENV ?= development
ENV_FILE ?= .$(ENV).env

.PHONY: all build push run rund stop clean tag

all: build run

build:
	docker build --rm -t $(IMAGE) docker
	docker tag -f $(IMAGE) $(USERNAME)/$(NAME):latest

push:
	docker push $(IMAGE)
	docker push $(USERNAME)/$(NAME):latest

$(ENV_FILE): $(ENV_FILE).default
	cp $(ENV_FILE).default $(ENV_FILE)

run: | $(ENV_FILE)
	TAG=$(TAG) ENV_FILE=$(ENV_FILE) docker-compose \
		-f docker-compose.$(ENV).yml \
		up

rund: | $(ENV_FILE)
	TAG=$(TAG) ENV_FILE=$(ENV_FILE) docker-compose \
		-f docker-compose.$(ENV).yml \
		up -d

stop:
	TAG=$(TAG) ENV_FILE=$(ENV_FILE) docker-compose \
		-f docker-compose.$(ENV).yml \
		stop

clean:
	TAG=$(TAG) ENV_FILE=$(ENV_FILE) docker-compose \
		-f docker-compose.$(ENV).yml \
		rm -fv

tag:
	git tag "v$(TAG)"
	git push --tags

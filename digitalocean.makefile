SIZE ?= 4gb
NAME = freenet-do-$(SIZE)
ENV = digitalocean
ENV_FILE = .$(ENV)-$(SIZE).env

.PHONY: machine deploy env tunnel stop

machine:
	docker-machine create \
		--driver digitalocean \
		--digitalocean-access-token "${DIGITALOCEAN_ACCESS_TOKEN}" \
		--digitalocean-region "${DIGITALOCEAN_REGION}" \
		--digitalocean-size "$(SIZE)" \
		$(NAME)

env-cmd:
	docker-machine env $(NAME)

env-check:
	docker-machine active | grep $(NAME)

deploy: env-check
	ENV=$(ENV) ENV_FILE=$(ENV_FILE) make rund

tunnel:
	docker-machine ssh $(NAME) \
		-L 8888:localhost:8888 \
		-L 9481:localhost:9481

stop:
	docker-machine stop $(NAME)

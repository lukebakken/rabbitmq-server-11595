.PHONY: clean down up perms rmq-perms logs

DOCKER_FRESH ?= false

clean: perms
	git clean -xffd

down:
	docker compose down

up: rmq-perms
ifeq ($(DOCKER_FRESH),true)
	docker compose up --pull always --remove-orphans
else
	docker compose up --remove-orphans
endif

perms:
	sudo chown -R "$$(id -u):$$(id -g)" data

rmq-perms:
	sudo chown -R '999:999' data

logs:
	docker compose logs rabbitmq-1 > $(CURDIR)/rabbitmq-1-docker.log
	docker compose logs rabbitmq-2 > $(CURDIR)/rabbitmq-2-docker.log
	docker compose logs rabbitmq-3 > $(CURDIR)/rabbitmq-3-docker.log

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
	docker compose logs rabbit-1 > $(CURDIR)/rabbit-1-docker.log
	docker compose logs rabbit-2 > $(CURDIR)/rabbit-2-docker.log
	docker compose logs rabbit-3 > $(CURDIR)/rabbit-3-docker.log

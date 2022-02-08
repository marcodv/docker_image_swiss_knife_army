#!make

DJANGO_CONTAINER_NAME=swiss-knife
COMPOSE_LOCAL=compose.local.yml


RUN_COMMAND = docker exec -it $(DJANGO_CONTAINER_NAME) bash -c

## DOCKER COMPOSE
docker:
	docker compose -f $(COMPOSE_LOCAL) up ${ARGS}
docker-d:
	ARGS=-d make docker
docker-build:
	COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker compose -f $(COMPOSE_LOCAL) build ${ARGS}
docker-build-clean:
	ARGS=--no-cache make docker-build
docker-stop:
	docker compose -f $(COMPOSE_LOCAL) stop ${ARGS}
##---------------
	
## DOCKER
exec: 
	docker exec -it $(DJANGO_CONTAINER_NAME) bash ${ARGS}
##---------------

## DJANGO COMMANDS
command:
	$(RUN_COMMAND) "${COMMAND}"

test:
	COMMAND="pytest ${APP} -svv" make command


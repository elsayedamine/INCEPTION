all: up

up:
	@docker compose -f ./srcs/docker-compose.yml up

down:
	@docker compose -f ./srcs/docker-compose.yml down

start:
	@docker compose -f ./srcs/docker-compose.yml start

stop:
	@docker compose -f ./srcs/docker-compose.yml stop

build:
	@docker compose -f ./srcs/docker-compose.yml build

rebuild:
	@docker compose -f ./srcs/docker-compose.yml build --no-cache

status:
	@docker ps
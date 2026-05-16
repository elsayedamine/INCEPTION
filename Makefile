
all: setup up

setup:
	@mkdir -p /home/$(USER)/data/nginx
	@mkdir -p /home/$(USER)/data/mariadb
	@echo "Directories created successfully."

up:
	@docker compose -f srcs/docker-compose.yml up --build -d 
build:
	@docker compose -f srcs/docker-compose.yml build --no-cache
down:
	@docker compose -f srcs/docker-compose.yml down
restart:
	@docker compose -f srcs/docker-compose.yml restart
clean:
	@docker compose -f srcs/docker-compose.yml down --volumes

fclean: clean
	@sudo rm -rf /home/$(USER)/data/nginx
	@sudo rm -rf /home/$(USER)/data/mariadb
	@sudo rm -rf /home/$(USER)/data/websesrv
	@echo "All data directories removed."

rebuild: fclean all

setup_bonus:
	@mkdir -p /home/$(USER)/data/webserv

re:clean up

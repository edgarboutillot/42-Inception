.PHONY: all prepare down clean build mariadb wordpress nginx logs

all: prepare
	sudo docker-compose -f srcs/docker-compose.yml up -d --build

up:
	sudo docker-compose -f srcs/docker-compose.yml up -d

build:
	sudo docker-compose -f srcs/docker-compose.yml build mariadb wordpress nginx

mariadb:
	sudo docker-compose -f srcs/docker-compose.yml build mariadb

wordpress:
	sudo docker-compose -f srcs/docker-compose.yml build wordpress

nginx:
	sudo docker-compose -f srcs/docker-compose.yml build nginx

logs:
	sudo docker-compose -f srcs/docker-compose.yml logs mariadb wordpress nginx

prepare:
	sudo mkdir -p /home/edgar/data
	sudo mkdir -p /home/edgar/data/wordpress
	sudo mkdir -p /home/edgar/data/mariadb
	@sudo chmod 777 /home/edgar/data/wordpress
	@sudo chmod 777 /home/edgar/data/mariadb

down:
	@docker-compose -f srcs/docker-compose.yml down -v

clean: down
	@docker system prune -af
	@sudo rm -rf /home/edgar/data
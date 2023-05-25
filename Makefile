# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: f██████ <f██████@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/01/03 12:33:02 by f██████           #+#    #+#              #
#    Updated: 2023/03/29 16:48:09 by f██████          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# minimal color codes
END=$'\x1b[0m
REV=$'\x1b[7m
GREY=$'\x1b[30m
RED=$'\x1b[31m
GREEN=$'\x1b[32m
CYAN=$'\x1b[36m
WHITE=$'\x1b[37m

NAME = inception

all : $(NAME)

$(NAME) : build
	@make up

build :
	@echo "${YELLOW}> Image building 🎉${END}"
	@mkdir -p ${HOME}/data/wordpress
	@mkdir -p ${HOME}/data/mariadb
	@mkdir -p ${HOME}/data/adminer
	@docker-compose -f ./srcs/docker-compose.yml build
		
up :
	@echo "${YELLOW}> Turning up images 🎉${END}"
	@docker-compose -f ./srcs/docker-compose.yml up -d
	
down :
	@echo "${YELLOW}> Turning down images ❌${END}"
	@docker-compose -f ./srcs/docker-compose.yml down

re:
	@make down
	@make clean
	@make build
	@make up

clean: down
	@echo "${YELLOW}> Cleaning and deleting all images 🧹${END}"
	@ { docker volume ls -q ; echo null; } | xargs -r docker volume rm --force
	@sudo rm -rf ${HOME}/data/

.PHONY:	all re down clean up build
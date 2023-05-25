#!/bin/sh

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

if [ ! -f "/opt/minecraft/eula.txt" ]; then
    echo "eula=true" > /opt/minecraft/eula.txt
fi

cd /opt/minecraft;
/usr/lib/jvm/jdk-20/bin/java -Xmx1024M -Xms1024M -jar /opt/minecraft/server.jar nogui
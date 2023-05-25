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

if [ ! -f "/var/www/adminer/index.php" ]; then

    echo "Installing adminer";

    wget "http://www.adminer.org/latest.php" -O /var/www/adminer/index.php;
    chown -R www-data:www-data /var/www/adminer/index.php;
    chmod 755 /var/www/adminer/index.php;

    # Change owner of adminer files
    chown -R www-data:www-data /var/www/adminer;
    chmod -R 755 /var/www/adminer;
fi

php-fpm7.3 -F;
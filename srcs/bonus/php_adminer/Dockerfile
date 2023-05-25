FROM debian:buster

RUN apt-get -yqq update;

# Install php-fpm
RUN apt-get -yqq install -y php-fpm php-mysql default-mysql-client php-pear php-dev wget;

# Modify config for listen port 9000
RUN sed -E -i 's/^(\s*listen\s*=\s*).+$/\1php_adminer:9000/g' /etc/php/7.3/fpm/pool.d/www.conf;

RUN mkdir -p /run/php/;

RUN mkdir -p /var/www/adminer;

# Copy entrypoint
COPY ./script/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh"]
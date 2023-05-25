FROM debian:buster

# Define environment variables
ENV DEBIAN_FRONTEND=noninteractive
ARG DB_NAME=;
ARG DB_USER=;
ARG DB_PASSWORD=;
ARG DB_HOST=;
ARG WP_URL=;
ARG WP_TITLE=;
ARG WP_SUPERADMIN_USER=;
ARG WP_SUPERADMIN_EMAIL=;
ARG WP_SUPERADMIN_PASSWORD=;
ARG WP_ADMIN_USER=;
ARG WP_ADMIN_EMAIL=;
ARG WP_ADMIN_PASSWORD=;
ARG REDIS_PASSWORD=;

RUN apt-get -yqq update;

# Install php-fpm
RUN apt-get -yqq install -y php-fpm php-mysql default-mysql-client php-pear php-dev curl;

# Modify config for listen port 9000
RUN sed -E -i 's/^(\s*listen\s*=\s*).+$/\1php_wordpress:9000/g' /etc/php/7.3/fpm/pool.d/www.conf;

RUN mkdir -p /run/php/;

# Install imagemagick extension
RUN apt-get update && apt-get install -y libmagickwand-dev --no-install-recommends \
    && pecl install imagick;

RUN echo "extension=imagick.so" >> /etc/php/7.3/cli/php.ini;

# Install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
RUN chmod +x wp-cli.phar;
RUN mv wp-cli.phar /usr/local/bin/wp;
RUN wp core download --allow-root --path=/tmp/wordpress;

COPY ./media/image1.jpg /var/www/localhost/image1.jpg

RUN chown -R www-data:www-data /var/www/localhost;
RUN chmod -R 755 /var/www/localhost;

# Copy entrypoint
COPY ./script/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh"]
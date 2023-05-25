FROM debian:buster

# Define environment variables
ENV DEBIAN_FRONTEND=noninteractive
ARG DB_NAME=;
ARG DB_USER=;
ARG DB_PASSWORD=;
ARG DB_ROOT_PASSWORD=;

RUN apt-get -yqq update

# Install mariadb
RUN apt-get -yqq install -y mariadb-server;

# Create directory for mariadb
RUN mkdir -p /var/run/mysql;
RUN chown mysql:mysql /var/run/mysql;

# Create database for wordpress
RUN	service mysql start \
&& mysql -u root -e "CREATE DATABASE ${DB_NAME};" && \
mysql -u root -e "CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';" && \
mysql -u root -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';" && \
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
RUN	service mysql stop;
 
CMD ["mysqld", "--bind-address=0.0.0.0"]

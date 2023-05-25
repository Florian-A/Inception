FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -yqq update;

# Install nginx
RUN apt-get -yqq install -y nginx openssl;

# Copy config
COPY ./config/default /etc/nginx/sites-available/default

# Create directory for nginx
RUN mkdir -p /var/www/localhost;

# Create self-signed certificate
RUN openssl req -x509 -nodes -days 365 -subj "/C=CA/ST=QC/O=42, Inc./CN=localhost" \
-newkey rsa:2048 -keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt;

CMD ["nginx", "-g", "daemon off;"]
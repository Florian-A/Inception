FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -yqq update;

# Install nginx
RUN apt-get -yqq install -y nginx openssl git curl;

# Install nodejs
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt install nodejs;

# Copy config
COPY ./config/default /etc/nginx/sites-available/default

# Create self-signed certificate
RUN openssl req -x509 -nodes -days 365 -subj "/C=CA/ST=QC/O=42, Inc./CN=localhost" \
-newkey rsa:2048 -keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt;

# Create directory for nginx
RUN mkdir -p /var/www/localhost;

# Copy jsrassik project and building it
RUN git clone https://github.com/florian-a/jsrassik /tmp/jsrassik;
RUN cd /tmp/jsrassik && npm install && npm run build;
RUN cp -r /tmp/jsrassik/build/* /var/www/localhost

CMD ["nginx", "-g", "daemon off;"]
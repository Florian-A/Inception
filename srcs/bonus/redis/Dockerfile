FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive;
ARG REDIS_PASSWORD=;
RUN apt-get -yqq update;

# Install redis
RUN apt-get -yqq install -y redis-server;

# Config modification
RUN sed -i "s/^daemonize yes$/daemonize no/g" /etc/redis/redis.conf;
RUN sed -i "s/^bind .*/bind 0.0.0.0/g" /etc/redis/redis.conf;
RUN sed -i "s/# requirepass foobared/requirepass ${REDIS_PASSWORD}/g" /etc/redis/redis.conf;
RUN sed -i "s/^protected-mode yes$/protected-mode no/g" /etc/redis/redis.conf;

CMD [ "redis-server", "/etc/redis/redis.conf" ]
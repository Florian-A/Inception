FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive;
ARG REDIS_PASSWORD=;
RUN apt-get -yqq update;

# Install redis
RUN apt-get -yqq install -y wget libc6-i386 libc6-x32 libasound2 libfreetype6 libx11-6 libxext6 libxi6 libxrender1 libxtst6;

RUN wget https://download.oracle.com/java/20/latest/jdk-20_linux-x64_bin.deb;
RUN dpkg -i jdk-20_linux-x64_bin.deb;
#RUN rm jdk-20_linux-x64_bin.deb;

# Download minecraft server
RUN mkdir /opt/minecraft;
RUN chmod 777 /opt/minecraft;
RUN wget https://launcher.mojang.com/v1/objects/a16d67e5807f57fc4e550299cf20226194497dc2/server.jar -O /opt/minecraft/server.jar;

# Copy entrypoint
COPY ./script/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh"]
FROM debian:buster

ARG FTP_USER=;
ARG FTP_PASSWORD=;

ENV DEBIAN_FRONTEND=noninteractive;
RUN apt-get -yqq update;

# Install ftp server
RUN apt-get -yqq install -y proftpd;

# Configure ftp server
RUN sed -i 's/^DelayEngine on$/DelayEngine off/' /etc/proftpd/proftpd.conf
RUN sed -i 's/^#\s*PassivePorts/PassivePorts/' /etc/proftpd/proftpd.conf
RUN sed -i 's/49152/50150/g' /etc/proftpd/proftpd.conf
RUN sed -i 's/65534/50250/g' /etc/proftpd/proftpd.conf
RUN sed -i '/^# DefaultRoot/a\DefaultRoot \/var\/www\/localhost' /etc/proftpd/proftpd.conf
RUN sed -i '/^# DefaultRoot/d' /etc/proftpd/proftpd.conf

# Create user
RUN useradd -m $FTP_USER;
RUN echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

CMD [ "proftpd", "-n"]
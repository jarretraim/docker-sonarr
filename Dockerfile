# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:latest

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ENV DEBIAN_FRONTEND noninteractive

# Install Sonaar
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC \
	&& echo "deb http://apt.sonarr.tv/ master main" | tee /etc/apt/sources.list.d/sonarr.list \
	&& apt-get update -q \
	&& apt-get install -qy nzbdrone mediainfo \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Data Storage & Permissions
RUN chown -R nobody:users /opt/NzbDrone \
  ; mkdir -p /volumes/config/sonarr /volumes/completed /volumes/media \
  && chown -R nobody:users /volumes

RUN mkdir /etc/service/sonarr
ADD sonarr.sh /etc/service/sonarr/run
RUN chmod +x /etc/service/sonarr/run

# Enable SSH
# RUN rm -f /etc/service/sshd/down
# ADD id_rsa.pub /tmp/id_rsa.pub
# RUN cat /tmp/id_rsa.pub >> /root/.ssh/authorized_keys && rm -f /tmp/id_rsa.pub
# EXPOSE 22

# Web Interface
EXPOSE 8989

# Data storage
VOLUME /volumes/config
VOLUME /volumes/completed
VOLUME /volumes/media


# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:latest

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Add respository
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC \
	&& echo "deb http://apt.sonarr.tv/ master main" | tee /etc/apt/sources.list.d/sonarr.list \
	&& apt-get update -q \
	&& apt-get install -qy nzbdrone mediainfo \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /etc/service/sonarr
ADD sonarr.sh /etc/service/sonarr/run

EXPOSE 8989 	# Web Interface


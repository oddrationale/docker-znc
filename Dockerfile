# Docker image running ZNC 1.4
#
# VERSION   0.0.2

FROM ubuntu:14.04
MAINTAINER Dariel Dato-on <oddrationale@gmail.com>

# Compile ZNC from source
ADD http://znc.in/releases/znc-1.4.tar.gz /tmp/
ADD build.sh /tmp/
RUN /tmp/build.sh

# Create a 'znc' user so we don't run znc as root. HOME=/var/znc
RUN adduser --system --group --home /var/znc --shell /bin/bash znc
USER znc
ENV HOME /var/znc

# Add data volume to hold ZNC config files
VOLUME ["/var/znc"]

ENTRYPOINT ["/usr/local/bin/znc"]
CMD ["--foreground"]

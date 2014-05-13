# Docker image running ZNC 1.4
#
# VERSION   0.0.2

FROM ubuntu:14.04
MAINTAINER Dariel Dato-on <oddrationale@gmail.com>

# Compile ZNC from source
ADD http://znc.in/releases/znc-1.4.tar.gz /tmp/
RUN apt-get update && \
    apt-get -y install build-essential libssl-dev libperl-dev pkg-config
RUN cd /tmp && \
    tar -xzvf znc*.*gz && \
    cd znc* && \
    ./configure && \
    make && \
    make install

# Clean up ZNC install
RUN rm -rf /tmp/znc* && \
    apt-get -y autoremove build-essential libssl-dev libperl-dev pkg-config && \
    apt-get clean

# Create a 'znc' user so we don't run znc as root. HOME=/var/znc
RUN adduser --system --group --home /var/znc --shell /bin/bash znc
USER znc
ENV HOME /var/znc

# Add data volume to hold ZNC config files
VOLUME ["/var/znc"]

ENTRYPOINT ["/usr/local/bin/znc"]
CMD ["--foreground"]

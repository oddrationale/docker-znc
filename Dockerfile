# Latest version of ZNC from ppa:teward/znc
#
# VERSION   0.0.1

FROM ubuntu:12.04

# Manually add ppa:teward/znc instead of using add-apt-repository,
# which pulls in too many unneeded dependencies. Keep it slim!
RUN echo "deb http://ppa.launchpad.net/teward/znc/ubuntu precise main" > /etc/apt/sources.list.d/teward-znc-precise.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E616D378
RUN apt-get update
RUN apt-get install -y znc

# Create a 'znc' user so we don't run znc as root. HOME=/var/znc
RUN adduser --system --group --home /var/znc --shell /bin/bash znc

# Create some helper scripts to be used by 'docker run'. 
# When mounting data volumes, it mounts as root:root. Helper scripts
# chown's /var/znc back to znc:znc so it can be written by znc.
RUN echo "#!/bin/bash\nchown znc:znc /var/znc && su - znc -c 'znc --makeconf'" > /usr/local/bin/znc_makeconf
RUN chmod +x /usr/local/bin/znc_makeconf
RUN echo "#!/bin/bash\nchown znc:znc /var/znc && su - znc -c 'znc --foreground'" > /usr/local/bin/znc_foreground
RUN chmod +x /usr/local/bin/znc_foreground

CMD ["znc_makeconf"]

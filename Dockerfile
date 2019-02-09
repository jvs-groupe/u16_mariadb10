# Version 1.0.2

FROM jvsgroupe/u16_core
MAINTAINER Jérôme KLAM, "jerome.klam@jvs.fr"

ENV DEBIAN_FRONTEND noninteractive

## Install MariaDB.
ENV INITRD No
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
RUN add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://ftp.igh.cnrs.fr/pub/mariadb/repo/10.1/ubuntu xenial main'

# Expose our data, log, and configuration directories.
VOLUME ["/data", "/var/log/mysql", "/etc/mysql"]

RUN apt-get update && \
    apt-get install --no-install-recommends -y mariadb-server && \
    sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/my.cnf && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    update-rc.d -f mysql disable

ADD docker /scripts

EXPOSE 3306

# Use baseimage-docker's init system.
RUN chmod +x /scripts/start.sh
ENTRYPOINT ["/scripts/start.sh"]
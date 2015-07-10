FROM surveil/surveil:0.13.1
MAINTAINER Frédéric Vachon <frederic.vachon@savoirfairelinux.com>

RUN apt-get install -y subversion && \
	svn checkout https://github.com/savoirfairelinux/monitoring-tools/trunk/packs/linux-drupal /packs/linux-drupal && \
	apt-get remove -y subversion

COPY ./init.sh /init.sh

CMD sleep 60 && /init.sh

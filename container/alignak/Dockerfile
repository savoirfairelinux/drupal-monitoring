FROM savoirfairelinux/surveil-alignak:0.4.4
MAINTAINER Frédéric Vachon <frederic.vachon@savoirfairelinux.com>

RUN apt-get update && \
	apt-get install -y php-pear && \
	pear channel-discover pear.drush.org && \
	pear install drush/drush

RUN useradd -m alignak

RUN apt-get update && apt-get install sudo openssh-client

USER alignak
COPY drupal.aliases.drushrc.php /home/alignak/.drush/drupal.aliases.drushrc.php
COPY ssh /home/alignak/.ssh
RUN eval `ssh-agent` ssh-add
USER root

CMD /usr/bin/supervisord                                                                                                  

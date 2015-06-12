FROM savoirfairelinux/surveil-alignak:0.7.0
MAINTAINER Frédéric Vachon <frederic.vachon@savoirfairelinux.com>

RUN apt-get update && \
	apt-get install -y php-pear && \
	pear channel-discover pear.drush.org && \
	pear install drush/drush

RUN apt-get update && apt-get install -y sudo openssh-client

USER alignak

COPY drupal.aliases.drushrc.php /home/alignak/.drush/drupal.aliases.drushrc.php
COPY ssh /home/alignak/.ssh

RUN eval `ssh-agent` ssh-add

USER root
RUN chown -R alignak:alignak /home/alignak
RUN chmod 700 /home/alignak/.ssh
RUN chmod 600 /home/alignak/.ssh/id_rsa
RUN chmod 600 /home/alignak/.ssh/id_rsa.pub

CMD /usr/bin/supervisord                                                                                                  

FROM savoirfairelinux/surveil-alignak:0.7.0
MAINTAINER Frédéric Vachon <frederic.vachon@savoirfairelinux.com>

RUN apt-get update && \
	apt-get install -y php-pear && \
	pear channel-discover pear.drush.org && \
	pear install drush/drush

RUN apt-get update && apt-get install -y sudo openssh-client

# Install plugins
RUN apt-get update && apt-get install -y subversion python-setuptools && \
	svn checkout https://github.com/savoirfairelinux/monitoring-tools/branches/drupal/plugins/check-drupal-cache /plugins/drupal_cache && \
	svn checkout https://github.com/savoirfairelinux/monitoring-tools/branches/drupal/plugins/check-drupal-codebase /plugins/drupal_codebase && \
	svn checkout https://github.com/savoirfairelinux/monitoring-tools/branches/drupal/plugins/check-drupal-cron /plugins/drupal_cron && \
	svn checkout https://github.com/savoirfairelinux/monitoring-tools/branches/drupal/plugins/check-drupal-database /plugins/drupal_database && \
	svn checkout https://github.com/savoirfairelinux/monitoring-tools/branches/drupal/plugins/check-drupal-extensions /plugins/drupal_extensions && \
	svn checkout https://github.com/savoirfairelinux/monitoring-tools/branches/drupal/plugins/check-drupal-logging /plugins/drupal_logging && \
	svn checkout https://github.com/savoirfairelinux/monitoring-tools/branches/drupal/plugins/check-drupal-security /plugins/drupal_security && \
	svn checkout https://github.com/savoirfairelinux/monitoring-tools/branches/drupal/plugins/check-drupal-status /plugins/drupal_status && \
	svn checkout https://github.com/savoirfairelinux/monitoring-tools/branches/drupal/plugins/check-drupal-views /plugins/drupal_views && \
	chmod +x /plugins/drupal_cache/shinkenplugins/plugins/drupal_cache/drupal_cache.py && \
	chmod +x /plugins/drupal_codebase/shinkenplugins/plugins/drupal_codebase/drupal_codebase.py && \
	chmod +x /plugins/drupal_cron/shinkenplugins/plugins/drupal_cron/drupal_cron.py && \
	chmod +x /plugins/drupal_database/shinkenplugins/plugins/drupal_database/drupal_database.py && \
	chmod +x /plugins/drupal_extensions/shinkenplugins/plugins/drupal_extensions/drupal_extensions.py && \
	chmod +x /plugins/drupal_logging/shinkenplugins/plugins/drupal_logging/drupal_logging.py && \
	chmod +x /plugins/drupal_security/shinkenplugins/plugins/drupal_security/drupal_security.py && \
	chmod +x /plugins/drupal_status/shinkenplugins/plugins/drupal_status/drupal_status.py && \
	chmod +x /plugins/drupal_views/shinkenplugins/plugins/drupal_views/drupal_views.py && \
	apt-get remove -y subversion

## Install plugins dependencies
RUN mkdir -p /opt/drupalplugins
RUN virtualenv /opt/drupalplugins/env
ENV PATH=$PATH:/opt/drupalplugins/env/bin
RUN /opt/drupalplugins/env/bin/pip install "pbr>=0.6,!=0.7,<1.0" shinkenplugins

## Install Plugins
RUN mkdir -p /usr/lib/alignak/plugins
RUN cd /plugins/drupal_cache \
	&& sudo /opt/drupalplugins/env/bin/python setup.py install  \
	&& ln -s /opt/drupalplugins/env/bin/check_drupal_cache /usr/lib/alignak/plugins/
RUN cd /plugins/drupal_codebase \
	&& sudo /opt/drupalplugins/env/bin/python setup.py install  \
	&& ln -s /opt/drupalplugins/env/bin/check_drupal_codebase /usr/lib/alignak/plugins/
RUN cd /plugins/drupal_cron \
	&& sudo /opt/drupalplugins/env/bin/python setup.py install  \
	&& ln -s /opt/drupalplugins/env/bin/check_drupal_cron /usr/lib/alignak/plugins/
RUN cd /plugins/drupal_database \
	&& sudo /opt/drupalplugins/env/bin/python setup.py install  \
	&& ln -s /opt/drupalplugins/env/bin/check_drupal_database /usr/lib/alignak/plugins/
RUN cd /plugins/drupal_extensions \
	&& sudo /opt/drupalplugins/env/bin/python setup.py install  \
	&& ln -s /opt/drupalplugins/env/bin/check_drupal_extensions /usr/lib/alignak/plugins/
RUN cd /plugins/drupal_logging \
	&& sudo /opt/drupalplugins/env/bin/python setup.py install  \
	&& ln -s /opt/drupalplugins/env/bin/check_drupal_logging /usr/lib/alignak/plugins/
RUN cd /plugins/drupal_security \
	&& sudo /opt/drupalplugins/env/bin/python setup.py install  \
	&& ln -s /opt/drupalplugins/env/bin/check_drupal_security /usr/lib/alignak/plugins/
RUN cd /plugins/drupal_status \
	&& sudo /opt/drupalplugins/env/bin/python setup.py install  \
	&& ln -s /opt/drupalplugins/env/bin/check_drupal_status /usr/lib/alignak/plugins/
RUN cd /plugins/drupal_views \
	&& sudo /opt/drupalplugins/env/bin/python setup.py install  \
	&& ln -s /opt/drupalplugins/env/bin/check_drupal_views /usr/lib/alignak/plugins/

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

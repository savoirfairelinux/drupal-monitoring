FROM samos123/drupal
MAINTAINER Frédéric Vachon <frederic.vachon@savoirfairelinux.com>

RUN apt-get update && apt-get install -y vim sudo openssh-server

RUN apt-get update && \
	apt-get install -y subversion python-setuptools && \
	svn checkout https://github.com/savoirfairelinux/monitoring-tools/branches/drupal/plugins/check-drupal-cache /opt/drupal_cache && \
	svn checkout https://github.com/savoirfairelinux/monitoring-tools/branches/drupal/plugins/check-drupal-codebase /opt/drupal_codebase && \
	svn checkout https://github.com/savoirfairelinux/monitoring-tools/branches/drupal/plugins/check-drupal-cron /opt/drupal_cron && \
	svn checkout https://github.com/savoirfairelinux/monitoring-tools/branches/drupal/plugins/check-drupal-database /opt/drupal_database && \
	svn checkout https://github.com/savoirfairelinux/monitoring-tools/branches/drupal/plugins/check-drupal-extensions /opt/drupal_extensions && \
	svn checkout https://github.com/savoirfairelinux/monitoring-tools/branches/drupal/plugins/check-drupal-logging /opt/drupal_logging && \
	svn checkout https://github.com/savoirfairelinux/monitoring-tools/branches/drupal/plugins/check-drupal-security /opt/drupal_security && \
	svn checkout https://github.com/savoirfairelinux/monitoring-tools/branches/drupal/plugins/check-drupal-status /opt/drupal_status && \
	svn checkout https://github.com/savoirfairelinux/monitoring-tools/branches/drupal/plugins/check-drupal-views /opt/drupal_views && \
	chmod +x /opt/drupal_cache/shinkenplugins/plugins/drupal_cache/drupal_cache.py && \
	chmod +x /opt/drupal_codebase/shinkenplugins/plugins/drupal_codebase/drupal_codebase.py && \
	chmod +x /opt/drupal_cron/shinkenplugins/plugins/drupal_cron/drupal_cron.py && \
	chmod +x /opt/drupal_database/shinkenplugins/plugins/drupal_database/drupal_database.py && \
	chmod +x /opt/drupal_extensions/shinkenplugins/plugins/drupal_extensions/drupal_extensions.py && \
	chmod +x /opt/drupal_logging/shinkenplugins/plugins/drupal_logging/drupal_logging.py && \
	chmod +x /opt/drupal_security/shinkenplugins/plugins/drupal_security/drupal_security.py && \
	chmod +x /opt/drupal_status/shinkenplugins/plugins/drupal_status/drupal_status.py && \
	chmod +x /opt/drupal_views/shinkenplugins/plugins/drupal_views/drupal_views.py && \
	apt-get remove -y subversion && \
	cd /opt/drupal_cache && \
	python setup.py develop

RUN apt-get update && \
	apt-get install -y php-pear && \
	pear channel-discover pear.drush.org && \
	pear install drush/drush && \
	drush pm-download site_audit

RUN adduser nagios && adduser nagios www-data
RUN sudo -u nagios drush pm-download site_audit

COPY ssh/id_rsa.pub /root/.ssh/authorized_keys
COPY ssh/id_rsa.pub /home/nagios/.ssh/authorized_keys

RUN chmod 700 /root/.ssh
RUN chown nagios:nagios /home/nagios/.ssh
RUN chmod 700 /home/nagios/.ssh

RUN chmod 600 /root/.ssh/authorized_keys
RUN chown nagios:nagios /home/nagios/.ssh/authorized_keys
RUN chmod 600 /home/nagios/.ssh/authorized_keys

# Install and configure NRPE
RUN apt-get update && apt-get install -y nagios-nrpe-server supervisor

COPY entrypoint.sh /
COPY etc/nagios/nrpe.cfg /etc/nagios/nrpe.cfg

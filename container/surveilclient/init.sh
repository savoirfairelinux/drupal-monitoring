#!/bin/bash

export SURVEIL_API_URL=http://surveil/v2
export SURVEIL_AUTH_URL=http://surveil/v2/auth

echo Ajout du host drupal
surveil config-host-delete --host_name drupal 
surveil config-host-create --host_name drupal --address drupal --use generic-host

echo Ajout du service check_drupal_cache
surveil config-service-delete --host_name drupal --service_description drupal_cache 
surveil config-service-create --host_name drupal \
                              --service_description drupal_cache \
                              --check_command check_nrpe!check_drupal_cache \
							  --check_period 24x7 \
							  --check_interval 5 \
							  --contact_groups admins \
							  --contacts admin \
							  --max_check_attempts 5 \
							  --notification_interval 30 \
							  --notification_period 24x7 \
							  --retry_interval 3

echo Ajout du service check_drupal_codebase
surveil config-service-delete --host_name drupal --service_description drupal_codebase 
surveil config-service-create --host_name drupal \
                              --service_description drupal_codebase \
                              --check_command check_nrpe!check_drupal_codebase \
							  --check_period 24x7 \
							  --check_interval 5 \
							  --contact_groups admins \
							  --contacts admin \
							  --max_check_attempts 5 \
							  --notification_interval 30 \
							  --notification_period 24x7 \
							  --retry_interval 3
							  
echo Ajout du service check_drupal_cron
surveil config-service-delete --host_name drupal --service_description drupal_cron 
surveil config-service-create --host_name drupal \
                              --service_description drupal_cron \
                              --check_command check_nrpe!check_drupal_cron \
							  --check_period 24x7 \
							  --check_interval 5 \
							  --contact_groups admins \
							  --contacts admin \
							  --max_check_attempts 5 \
							  --notification_interval 30 \
							  --notification_period 24x7 \
							  --retry_interval 3

echo Ajout du service check_drupal_database
surveil config-service-delete --host_name drupal --service_description drupal_database 
surveil config-service-create --host_name drupal \
                              --service_description drupal_database \
                              --check_command check_nrpe!check_drupal_database \
							  --check_period 24x7 \
							  --check_interval 5 \
							  --contact_groups admins \
							  --contacts admin \
							  --max_check_attempts 5 \
							  --notification_interval 30 \
							  --notification_period 24x7 \
							  --retry_interval 3

echo Ajout du service check_drupal_extensions
surveil config-service-delete --host_name drupal --service_description drupal_extensions 
surveil config-service-create --host_name drupal \
                              --service_description drupal_extensions \
                              --check_command check_nrpe!check_drupal_extensions \
							  --check_period 24x7 \
							  --check_interval 5 \
							  --contact_groups admins \
							  --contacts admin \
							  --max_check_attempts 5 \
							  --notification_interval 30 \
							  --notification_period 24x7 \
							  --retry_interval 3

echo Ajout du service check_drupal_logging
surveil config-service-delete --host_name drupal --service_description drupal_logging 
surveil config-service-create --host_name drupal \
                              --service_description drupal_logging \
                              --check_command check_nrpe!check_drupal_logging \
							  --check_period 24x7 \
							  --check_interval 5 \
							  --contact_groups admins \
							  --contacts admin \
							  --max_check_attempts 5 \
							  --notification_interval 30 \
							  --notification_period 24x7 \
							  --retry_interval 3

echo Ajout du service check_drupal_security
surveil config-service-delete --host_name drupal --service_description drupal_security 
surveil config-service-create --host_name drupal \
                              --service_description drupal_security \
                              --check_command check_nrpe!check_drupal_security \
							  --check_period 24x7 \
							  --check_interval 5 \
							  --contact_groups admins \
							  --contacts admin \
							  --max_check_attempts 5 \
							  --notification_interval 30 \
							  --notification_period 24x7 \
							  --retry_interval 3

echo Ajout du service check_drupal_status
surveil config-service-delete --host_name drupal --service_description drupal_status 
surveil config-service-create --host_name drupal \
                              --service_description drupal_status \
                              --check_command check_nrpe!check_drupal_status \
							  --check_period 24x7 \
							  --check_interval 5 \
							  --contact_groups admins \
							  --contacts admin \
							  --max_check_attempts 5 \
							  --notification_interval 30 \
							  --notification_period 24x7 \
							  --retry_interval 3

echo Ajout du service check_drupal_views
surveil config-service-delete --host_name drupal --service_description drupal_views 
surveil config-service-create --host_name drupal \
                              --service_description drupal_views \
                              --check_command check_nrpe!check_drupal_views \
							  --check_period 24x7 \
							  --check_interval 5 \
							  --contact_groups admins \
							  --contacts admin \
							  --max_check_attempts 5 \
							  --notification_interval 30 \
							  --notification_period 24x7 \
							  --retry_interval 3

surveil config-reload

echo Script termine

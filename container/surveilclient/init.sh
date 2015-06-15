#!/bin/bash

export SURVEIL_API_URL=http://surveil:8080/v2
export SURVEIL_AUTH_URL=http://surveil:8080/v2/auth

echo Ajout du pack Drupal
surveil-pack-upload --mongo-url mongo --mongo-port 27017 /packs/linux-drupal/

echo Ajout du host drupal
surveil config-host-delete --host_name drupal 
surveil config-host-create --host_name drupal \
                           --address drupal \
                           --use linux-drupal \
                           --custom_fields '{"_DRUPAL_OPTION":"-a @drupal -d /home/alignak/"}'

surveil config-reload

echo Script termine

while true; do
	sleep 60
done

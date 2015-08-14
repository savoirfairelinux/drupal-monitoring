#!/bin/bash

export SURVEIL_API_URL=http://surveil:5311/v2
export SURVEIL_AUTH_URL=http://surveil:5311/v2/auth

echo Adding drupal pack
surveil-pack-upload --mongo-uri mongo /packs/linux-drupal/

echo Adding drupal host
surveil config-host-delete --host_name drupal 
surveil config-host-create --host_name drupal \
	                       --address $HOST_ADDR \
                           --use linux-drupal \
						   --custom_fields '{"_DRUPAL_OPTIONS":"-a '$DRUPAL_ALIAS' -d /home/alignak/", "_JENKINS_OPTIONS": "-u '$JENKINS'", "_HTTP_LOAD_OPTIONS": "-u http://'$HOST_ADDR' -n 2 -q 2 -m 0", "_SELENIUM_SCENARIO":"'$SELENIUM_SCENARIO'"}'

surveil config-reload

echo Script done

while true; do
	sleep 60
done

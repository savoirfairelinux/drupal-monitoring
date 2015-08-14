# Containers stack for Drupal monitoring

This project provides a full solution to monitor multiple Drupal hosts.
The data gathering is mainly based on drush, the Drupal shell command line tool.

## Prerequisites

This stack is based on docker, so you'll need to install it.
Since it's a multi-container setup, another tool called docker-compose is used by the Makefile to manage the stack.

## Usage

### Demo

If you want to see what the project looks like, use the demonstration stack

``` bash
make build-demo
make demo
```

The container stack will stop after initializing the Drupal site.
You need to start it once again


``` bash
make demo
```

Access the [webui](http://localhost:80/view?view=drupalDashboard)

Wait a few minutes for the monitoring system to be configured and to gather data from its plugins.


### Production

To deploy Drupal monitoring using containers, these are the steps you need to follow:


#### SSH key

The Alignak container needs a RSA private key to use remote drush on the Drupal server.
Put the private key in `container/alignak/ssh`. This directory will be mounted at runtime in `/home/alignak`.


#### Drush alias

Also, put the alias config files used for remote drush call in `container/alignak/aliases`.


#### Selenium scenario

The Alignak container also needs a selenium scenario in order to perform a selenium check.
More informations about how to record a scenario is available [here](http://sfl-monitoring-tools.readthedocs.org/en/latest/plugins/check-selenium/plugin-check_selenium.html)


#### Monitoring system configuration

Then, you need to configure the monitoring system by editing docker-compose-production.yml.
In the surveilclient entry, set the environment variables accordingly.


|      VARIABLE     |                    MEANING                      |
|-------------------|:-----------------------------------------------:|
| HOST_ADDR         | Host address to monitor                         |
| DRUPAL_ALIAS      | Alias name that drush will use                  |
| JENKINS           | The jenkins job URL                             |
| SELENIUM_SCENARIO | The selenium scenario name (without .py)        |


You can configure only one host that way. If you want to configure multiple hosts,
edit the `init.sh` file in `container/surveilclient/`.
Copy and paste surveil config-host-create command to add more host.
The options are pretty straight forward. If you need more information about the custom fields, they are defined in linux-drupal pack that is hosted [here](http://github.com/savoirfairelinux/monitoring-tools/tree/master/packs/linux-drupal)


The surveil client documentation is available [here](http://surveil.readthedocs.org/)


#### Start the stack

To start the stack :

``` bash
make production
```

You need to wait a little more than one minute before the monitoring system is properly configured.
Then, the monitoring system needs to perform his first checks. You can force that via the Alignak webui at :

```
http://localhost:7767/all
```

#### Web ui

Once the first checks have been performed, go [here](http://localhost:80/view?view=drupalDashboard) to access the web ui.


#### Persistent data

Please note that there's some persitent data (for mongo and influxDB) located in the `container-data`.
If you want a fresh start, delete it :

``` bash
make remove-data
```


### Development

The development setup mounts the nagios plugins from the host disk.
It expects monitoring-tools project as your drupal-monitoring root sibling.
That means that it will mount plugins from `../monitoring-tools`.

You can clone this repository from `https://github.com/savoirfairelinux/monitoring-tools`

To start the stack :

``` bash
make
```

The first time you run it, the stack will stop after initializing the Drupal site.
Start it again :

``` bash
make develop
```

After that, you need to clone the Bansho project where ever you want :

``` bash
git clone git@github.com:stackforge/bansho.git
```

Then, from the Bansho directory, run :

``` bash
make build
make drupal
```

Now, everything is up and running.
However, you'll have to wait about one minute before the configuration is sent to Alignak.


Bansho : `localhost:8888`

Drupal : `localhost:80`

Alignak : `localhost:7767`

Surveil : `localhost:8080`

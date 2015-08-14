# Containers stack for the Bansho drupal module

This project provides the full stack needed for the Bansho drupal module development.

## Usage

### Prerequisites

This stack is based on docker, so you'll need to install it.  As it's a multi-container setup, another tool called docker-compose is used by the Makefile entries to manage the stack.


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

To access the webui :

``` bash
http://localhost:80/view?view=drupalDashboard
```

Wait a few minutes for the monitoring system to be configured and to gather data from its plugins.


### Production

To deploy drupal monitoring using containers, these are the steps you need to follow:
The Alignak container needs a RSA private key to use remote drush on the Drupal server.  Put the private key in `container/alignak/ssh`. This directory will be mounted at runtime in `/home/alignak`.  Also, put the aliases config files used from remote drush call in `container/alignak/aliases`.  The Alignak container also needs a selenium scenario in order to perform a selenium check.  More informations about how to record a scenario is available there :

```
http://sfl-monitoring-tools.readthedocs.org/en/latest/plugins/check-selenium/plugin-check_selenium.html
```


Then, you need to configure the monitoring system by editing docker-compose-production.yml.  In the surveilclient entry, set environment variables accordingly.


|      VARIABLE     |                    MEANING                      |
|-------------------|:-----------------------------------------------:|
| HOST_ADDR         | Host address to monitor                         |
| DRUPAL_ALIAS      | Alias name that drush will use                  |
| JENKINS           | The jenkins job URL                             |
| SELENIUM_SCENARIO | The selenium scenario name (without .py)        |


That way, it is only possible to configure a single host. However, if you want to configure more that one host, you'll have to edit the `init.sh` file that you can find in `container/surveilclient/`. Copy and paste surveil config-host-create command to add more host. The options are pretty straight forward. If you need more information about the custom fields, they are defined in linux-drupal pack that is hosted there :

```
https://github.com/savoirfairelinux/monitoring-tools
```


Once everything is setup, your ready to start the stack.


To start the stack :

``` bash
make production
```

You need to wait a little more that one minute before the monitoring system is properly configured.  Then, the monitoring system needs to perform his first checks. You can force that via the Alignak webui at : 

```
localhost:7767/all
```

Once the checks first checks have been performed, access the Bansho webui :

```
localhost:80/view?view=drupalDashboard
```

This is the webui URL to access the Drupal ui.


Please note that there's some persitent data (for mongo and influxDB) located in the `container-data` directory which you can delete if you want a fresh start.

``` bash
make remove-data
```


### Development

The development setup mounts the nagios plugins from the host disk. It expects you to have the monitoring-tools project as your drupal-monitoring root directory sibling. That means that it will mount plugins from `../monitoring-tools`.

You can clone this repository from `https://github.com/savoirfairelinux/monitoring-tools`

To start the stack :

``` bash
make
```


After that, you need to clone the Bansho project where ever you want :

``` bash
git clone git@github.com:stackforge/bansho.git
```

Then, from the Bansho directory, run :

``` bash
make drupal
```

Now, everything is up and running. However, you'll have to wait about one minute before the configuration is sent to Alignak.

Bansho : `localhost:8888`

Drupal : `localhost:80`

Alignak : `localhost:7767`

Surveil : `localhost:8080`

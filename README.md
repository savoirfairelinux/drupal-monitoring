# Containers stack for the Bansho drupal module

This project provides the full stack needed for the Bansho drupal module development.

## Usage

### Prerequisites

This stack is based on docker, so you'll need to install it.

As it's a multi-container setup, another tool called docker-compose is used by the Makefile entries

to manage the stack.


### Production

The production setup is meant to be used for demonstration purposes.

To start the stack :

``` bash
make production
```

The webui used to display data is Bansho. You'll need to clone this project :

``` bash
git clone git@github.com:stackforge/bansho.git
```

Once your stack is running, go into the Banso project root directory and run :


``` bash
make drupal
```

The Bansho container will link to the drupal monitoring stack.



### Development

The development setup mounts the nagios plugins from the host disk.

It expects you to have the monitoring-tools project as your drupal-monitoring root directory sibling.

That means that it will mount plugins from `../monitoring-tools`.

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


Now, everything is up and running. However, you'll have to wait about one minute before the
configuration is sent to Alignak.



Bansho : `localhost:8888`

Drupal : `localhost:80`

Alignak : `localhost:7767`

Surveil : `localhost:8080`

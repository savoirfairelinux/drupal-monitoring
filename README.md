# Containers stack for the Bansho drupal module

This project provides the full stack needed for the Bansho drupal module development.

## Usage

First of all, build the stack :

```
docker-compose build
```

Then, start it :

```
docker-compose up
```

As the Drupal container needs to initialize itself and create a database,
the first time you'll run it, it will stop. Once stopped, start it again :

```
docker-compose up
```

After that, you need to clone the Bansho project where ever you want :

```
git clone git@github.com:stackforge/bansho.git
```

Then, from the Bansho directory, run :

```
make drupal
```


Now, everything is up and running. However, you'll have to wait about one minute before the
Drupal host and services are sent and monitored by Alignak

Bansho : `localhost:8888`

Drupal : `localhost:80`

Alignak : `localhost:7767`

Surveil : `localhost:8080`


## Notes

There's a RSA key pair in the `container/alignak/ssh` directory. The public key is in the authorized keys of the 
Drupal container allowing the Alignak container to run drush remote command using aliases.

FROM ubuntu:trusty
MAINTAINER Frédéric Vachon <frederic.vachon@savoirfairelinux.com>

RUN apt-get update && apt-get install -y openssh-server python-pip python-dev
RUN pip install python-surveilclient==0.5.1

COPY ./init.sh /init.sh

CMD sleep 60 && /init.sh

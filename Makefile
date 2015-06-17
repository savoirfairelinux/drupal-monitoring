PROJECT=$(shell pwd)

all: remove build develop

clean: kill remove

build:
	sudo docker-compose build

rebuild:
	sudo docker-compose build --no-cache

develop:
	rm -rf $(PROJECT)/gen/.ssh/
	mkdir -p $(PROJECT)/gen/.ssh/
	ssh-keygen -N "" -f $(PROJECT)/gen/.ssh/id_rsa
	sudo docker-compose up

production:
	sudo docker-compose -f docker-compose-production.yml build
	rm -rf $(PROJECT)/gen/.ssh/
	mkdir -p $(PROJECT)/gen/.ssh/
	ssh-keygen -N "" -f $(PROJECT)/gen/.ssh/id_rsa
	sudo docker-compose -f docker-compose-production.yml up 

kill:
	sudo docker-compose kill

remove:
	sudo docker-compose rm

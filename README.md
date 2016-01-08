#Docker Node and mongo composite
 
## Install
- Windows/OSX [Docker toolbox](https://www.docker.com/docker-toolbox)
- Linux [Docker](https://docs.docker.com/engine/installation/ubuntulinux/) | [Docker compose](https://docs.docker.com/compose/install/)
 
## Create VM (on windows or OSX)
- run `init-vm.sh`
 
## Run
- Dev: `docker-compose -f dc-dev.yml up` `-d` for daemon mode
- Prod: `docker-compose -f dc-dev.yml up`

#ToDo
- aws deploy via docker
- DB connection check
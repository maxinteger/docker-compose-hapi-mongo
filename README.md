#Docker Node and mongo composite
 
## Install
- Windows/OSX [Docker toolbox](https://www.docker.com/docker-toolbox)
- Linux [Docker](https://docs.docker.com/engine/installation/ubuntulinux/) | [Docker compose](https://docs.docker.com/compose/install/)
 
## Create VM (on windows or OSX)
- run `init-vm.sh`
- VM IP address: `docker-machine ls`

## Run
- Dev: `docker-compose -f dc-dev.yml up` `-d` for daemon mode
- Prod: `docker-compose -f dc-dev.yml up`

## Links
- [dockerizing-django + slides](https://github.com/pulilab/dockerizing-django)
- [vagrant-boot2docker](https://github.com/silinternational/vagrant-boot2docker)

#ToDo
- aws deploy via docker
- DB connection check
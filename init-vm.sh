#!/usr/bin/env bash

WEB_DIR="web"
PROJECT_NAME=${PWD##*/}

# create new VM
docker-machine create -d virtualbox $(PROJECT_NAME)

docker-machine stop $(PROJECT_NAME)

# add share folder
#/c/Program\ Files/Oracle/VirtualBox/
VBoxManage sharedfolder add dev --hostpath "$(pwd)/$(WEB_DIR)" --name $(WEB_DIR) --automount

# mount share folder
docker-machine.exe ssh dev "sudo mkdir -p /$(WEB_DIR) && sudo mount -t vboxsf -o uid=1000,gid=1000 $(WEB_DIR) /$(WEB_DIR)"

docker-machine start $(PROJECT_NAME)

# activate VM
eval "$(docker-machine env )$($PROJECT_NAME)"


docker-machine.exe ssh dev "sudo mkdir -p /web && sudo mount -t vboxsf -o uid=1000,gid=1000 web $(pwd)/web"

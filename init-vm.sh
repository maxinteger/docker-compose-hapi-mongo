#!/usr/bin/env bash

WEB_DIR="web"
PROJECT_NAME=${PWD##*/}

if ! docker-machine ls | grep -q "$PROJECT_NAME"; then
    echo -e "- create new VM - '$PROJECT_NAME'\n"
    docker-machine create -d virtualbox "$PROJECT_NAME"

    if ! [[ $PWD == "/c/Users/"* ]]; then     # docker add /c/Users by default
        docker-machine stop "$PROJECT_NAME"

        echo -e "\n- Add share folder to the VM\n"

        # Add VirtualBox default location to the path
        export PATH="/c/Program Files/Oracle/VirtualBox:/Applications/VirtualBox.app/Contents/MacOS:$PATH"
        VBoxManage sharedfolder add "$PROJECT_NAME" --hostpath "$PWD/$WEB_DIR" --name "$WEB_DIR" --automount

        docker-machine start "$PROJECT_NAME"

        echo -e "\n- Mount share folder\n"
        docker-machine ssh "$PROJECT_NAME" "sudo mkdir -p $PWD/$WEB_DIR && sudo mount -t vboxsf -o uid=1000,gid=1000 $WEB_DIR $PWD/$WEB_DIR"
    fi
fi


echo -e "\n\nYou can setup the terminal environment with this command:"
echo -e "eval \"\$(docker-machine env --shell bash $PROJECT_NAME)\""

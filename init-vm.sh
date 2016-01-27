#!/usr/bin/env bash

FOLDERS=("web")

PROJECT_NAME=${PWD##*/}

if ! docker-machine ls | grep -q "$PROJECT_NAME"; then
    echo -e "- create new VM - '$PROJECT_NAME'\n"
    docker-machine create -d virtualbox "$PROJECT_NAME"

    if ! [[ $PWD == "/c/Users/"* ]]; then     # docker add /c/Users by default
        docker-machine stop "$PROJECT_NAME"

        echo -e "\n- Add share folder to the VM\n"

        # Add VirtualBox default location to the path
        export PATH="/c/Program Files/Oracle/VirtualBox:/Applications/VirtualBox.app/Contents/MacOS:$PATH"
        for SDIR in ${FOLDERS[@]}; do
            VBoxManage sharedfolder add "$PROJECT_NAME" --hostpath "$PWD/$SDIR" --name "$SDIR" --automount
        done
        # Enable symlinks in shared folder: http://www.ahtik.com/blog/fixing-your-virtualbox-shared-folder-symlink-error/
        #VBoxManage setextradata "$PROJECT_NAME" VBoxInternal2/SharedFoldersEnableSymlinksCreate/SDIR 1

        docker-machine start "$PROJECT_NAME"

        echo -e "\n- Mount share folder\n"
        for SDIR in ${FOLDERS[@]}; do
            docker-machine ssh "$PROJECT_NAME" "sudo mkdir -p $PWD/$SDIR && sudo mount -t vboxsf -o uid=1000,gid=1000 $SDIR $PWD/$SDIR"
        done
    fi
fi


echo -e "\n\nYou can setup the terminal environment with this command:"
echo -e "eval \"\$(docker-machine env --shell bash $PROJECT_NAME)\""

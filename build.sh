#!/bin/bash

# Function to copy .ssh directory to current directory
copy_ssh() {
    mkdir -p .ssh
    rsync -av ~/.ssh/id_rsa .ssh/
    rsync -av ~/.ssh/id_rsa.pub .ssh/

    ssh-keyscan github.com > ~/.ssh/known_hosts 2>/dev/null
    ssh-keyscan gitlab.com >> ~/.ssh/known_hosts 2>/dev/null
}

# Check if .ssh exists in the current directory
if [ ! -d "./.ssh" ]; then
    copy_ssh
fi

# Default docker tag
docker_tag="latest"

# Parse command line options
while getopts "ct:" opt; do
  case ${opt} in
    c )
      copy_ssh
      ;;
    t )
      docker_tag=$OPTARG
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      ;;
  esac
done

CURRENT_UID=$(id -u)
CURRENT_GID=$(id -g)
CURRENT_USER=$(id -un)

docker build -t lumeny/hexo:$docker_tag --build-arg UID=$CURRENT_UID --build-arg GID=$CURRENT_GID --build-arg USER=$CURRENT_USER .


#!/bin/bash

# Function to copy .ssh directory to current directory
copy_ssh() {
    rsync -av --exclude="authorized_keys" --exclude="config" ~/.ssh .
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

docker build -t lumeny/hexo:$docker_tag .

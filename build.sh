#!/bin/bash

# Function to copy .ssh directory to current directory

# Default docker tag
docker_tag="latest"

# Parse command line options
while getopts "t:" opt; do
  case ${opt} in
    t )
      docker_tag=$OPTARG
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      ;;
  esac
done

# Append all remaining command line parameters to docker build command
docker build  --build-arg ssh_prv_key="$(cat ~/.ssh/id_rsa)" --build-arg ssh_pub_key="$(cat ~/.ssh/id_rsa.pub)" -t lumeny/hexo:$docker_tag .

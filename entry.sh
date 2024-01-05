#!/bin/bash

echo "***** Running git config, user = ${GIT_USER}, email = ${GIT_EMAIL} *****"
git config --global user.email ${GIT_EMAIL}
git config --global user.name ${GIT_USER}

chmod 600 ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa.pub
chmod 700 ~/.ssh

git submodule update --recursive --remote

echo "***** Contents of public ssh key (for deploy) - *****"
cat ~/.ssh/id_rsa.pub

echo "***** Starting server on port ${HEXO_SERVER_PORT} *****"
hexo clean

hexo server -d -p ${HEXO_SERVER_PORT}

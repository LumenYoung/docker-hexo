#!/bin/bash

echo "***** Running git config, user = ${GIT_USER}, email = ${GIT_EMAIL} *****"
git config --global user.email ${GIT_EMAIL}
git config --global user.name ${GIT_USER}

git pull
git submodule update --recursive --remote

echo "***** Starting server on port ${HEXO_SERVER_PORT} *****"
hexo clean

hexo server -d -p ${HEXO_SERVER_PORT}

FROM node:current-bullseye

ARG UID
ARG GID
ARG USER

RUN apt-get update && \
    apt-get install git vim -y && \
    npm install -g hexo-cli && \
    if getent passwd $UID > /dev/null; then USER_NAME=$(getent passwd $UID | cut -d: -f1); else useradd -m -d /home/$USER -u $UID $USER && USER_NAME=$USER; fi && \
    if getent group $GID > /dev/null; then GROUP_NAME=$(getent group $GID | cut -d: -f1); else groupadd -g $GID $USER && GROUP_NAME=$USER; fi && \
    usermod -g $GROUP_NAME $USER_NAME && \
    mkdir -p /app && \
    mkdir -p /home/$USER_NAME/.ssh && \
    chown -R $USER_NAME:$GROUP_NAME /home/$USER_NAME/.ssh

USER $USER_NAME

ENV HEXO_SERVER_PORT=4000

ENV GIT_USER="Joe Bloggs"
ENV GIT_EMAIL="joe@bloggs.com"

WORKDIR /app

EXPOSE ${HEXO_SERVER_PORT}

COPY .ssh /home/$USER_NAME/.ssh
COPY entry.sh /

USER root

RUN chown -R $USER_NAME:$GROUP_NAME /app

USER $USER_NAME

ENTRYPOINT ["bash", "/entry.sh"]


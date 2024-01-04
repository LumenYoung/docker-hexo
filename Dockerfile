FROM node:current-bullseye

ARG UID
ARG GID
ARG USER

RUN apt-get update && \
    apt-get install git vim -y && \
    npm install -g hexo-cli && \
    useradd -m -d /home/$USER $USER && \
    if id -u $USER >/dev/null 2>&1; then usermod -o -u $UID -g $GID $USER ; fi && \
    mkdir -p /app && \
    mkdir -p /home/$USER/.ssh && \
    chown -R $USER:$USER /home/$USER/.ssh

USER $USER

ENV HEXO_SERVER_PORT=4000

ENV GIT_USER="Joe Bloggs"
ENV GIT_EMAIL="joe@bloggs.com"

WORKDIR /app

EXPOSE ${HEXO_SERVER_PORT}

COPY .ssh /home/$USER/.ssh
COPY entry.sh /

USER root

RUN chown -R $USER:$USER /app

USER $USER

ENTRYPOINT ["bash", "/entry.sh"]


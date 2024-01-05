FROM node:current-bullseye

USER root

# Set the server port as an environmental
ENV HEXO_SERVER_PORT=4000

ARG ssh_prv_key
ARG ssh_pub_key

# Set the git username and email
ENV GIT_USER="Joe Bloggs"
ENV GIT_EMAIL="joe@bloggs.com"

# Install requirements
RUN \
  apt-get update && \
  apt-get install git vim -y && \
  npm install -g hexo-cli 

# COPY --chown=root:root ./.ssh/id_rsa.pub ~/.ssh/

COPY entry.sh /

# Add the keys and set permissions
RUN  mkdir /root/.ssh && \
  echo "$ssh_prv_key" > /root/.ssh/id_rsa && \
  echo "$ssh_pub_key" > /root/.ssh/id_rsa.pub && \
  chmod 600 /root/.ssh/id_rsa && \
  chmod 600 /root/.ssh/id_rsa.pub && \
  ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN ls -la /root/.ssh

# Set workdir
WORKDIR /app

RUN git clone git@github.com:LumenYoung/hexo-site.git . && \
  git submodule update --init --recursive && \
  npm install

# Expose Server Port
EXPOSE ${HEXO_SERVER_PORT}

ENTRYPOINT ["bash", "/entry.sh"]
# CMD ["ls"]

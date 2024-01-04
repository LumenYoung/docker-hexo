FROM node:20-bullseye

MAINTAINER James Spurin <james@spurin.com>

USER root

# Set the server port as an environmental
ENV HEXO_SERVER_PORT=4000

# Set the git username and email
ENV GIT_USER="Joe Bloggs"
ENV GIT_EMAIL="joe@bloggs.com"

# Install requirements
RUN \
 apt-get update && \
 apt-get install git vim -y && \
 npm install -g hexo-cli && \
 npm i hexo-filter-mermaid-diagrams && \
 npm i hexo-generator-feed


# Set workdir
WORKDIR /app

# Expose Server Port
EXPOSE ${HEXO_SERVER_PORT}

COPY .ssh /root
COPY entry.sh /

CMD ["bash", "/entry.sh"]
# CMD ["ls"]

FROM debian:stretch

MAINTAINER Liu Chong <mail@clojure.cn>

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    sudo file curl wget git socat \
    ca-certificates openssl libssl-dev \
    build-essential autoconf libtool \
    nano vim emacs && \
    rm -rf /var/lib/apt/lists/*

ENV NVM_DIR="/usr/local/.nvm" \
    NODE_VERSION="6.9.1"

RUN git clone https://github.com/creationix/nvm.git "$NVM_DIR" && \
    cd "$NVM_DIR" && \
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin` && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> $HOME/.bashrc

RUN . $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default

ENV NODE_PATH="$NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules" \
    PATH="$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH"

ADD nvm /usr/local/bin

CMD ["bash"]

FROM debian:testing

MAINTAINER Liu Chong <mail@clojure.cn>

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install --no-install-recommends -y \
    sudo file curl wget git socat \
    ca-certificates openssl libssl-dev \
    build-essential autoconf libtool \
    nano vim emacs && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV NVM_DIR="/usr/local/.nvm" \
    NODE_VERSION_0="0.12.17" \
    NODE_VERSION_1="1.8.4" \
    NODE_VERSION_2="2.5.0" \
    NODE_VERSION_3="3.3.1" \
    NODE_VERSION_4="4.6.2" \
    NODE_VERSION_5="5.12.0" \
    NODE_VERSION_6="6.9.1" \
    NODE_VERSION_7="7.1.0" \
    NODE_VERSION_IOJS="$NODE_VERSION_3" \
    NODE_VERSION_LTS="$NODE_VERSION_6" \
    NODE_VERSION_CURRENT="$NODE_VERSION_7" \
    NODE_VERSION_DEFAULT="$NODE_VERSION_LTS"

RUN git clone https://github.com/creationix/nvm.git "$NVM_DIR" && \
    cd "$NVM_DIR" && \
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin` && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> $HOME/.bashrc

RUN . $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION_0 && \
    nvm install $NODE_VERSION_1 && \
    nvm install $NODE_VERSION_2 && \
    nvm install $NODE_VERSION_3 && \
    nvm install $NODE_VERSION_4 && \
    nvm install $NODE_VERSION_5 && \
    nvm install $NODE_VERSION_6 && \
    nvm install $NODE_VERSION_7 && \
    nvm alias iojs $NODE_VERSION_IOJS && \
    nvm alias lts $NODE_VERSION_LTS && \
    nvm alias current $NODE_VERSION_CURRENT && \
    nvm alias default $NODE_VERSION_DEFAULT && \
    nvm use default

ENTRYPOINT ["entrypoint.sh"]

CMD ["nvm"]

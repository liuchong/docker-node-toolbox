FROM debian:testing

MAINTAINER Liu Chong <mail@clojure.cn>

ENTRYPOINT ["/bin/bash", "--login", "-c"]

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install --no-install-recommends -y \
    sudo file curl wget git socat \
    ca-certificates openssl libssl-dev \
    build-essential autoconf libtool \
    python python3 \
    nano vim emacs && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV NVM_DIR="/usr/local/.nvm"

RUN git clone https://github.com/creationix/nvm.git "$NVM_DIR" && \
    cd "$NVM_DIR" && \
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin` && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> /etc/profile

RUN . $NVM_DIR/nvm.sh && \
    # v0
    nvm install 0.12.17 && \
    nvm alias v0 0.12.17 && \
    # v1
    nvm install 1.8.4 && \
    nvm alias v1 1.8.4 && \
    # v2
    nvm install 2.5.0 && \
    nvm alias v2 2.5.0 && \
    # v3, iojs
    nvm install 3.3.1 && \
    nvm alias v3 3.3.1 && \
    nvm alias iojs 3.3.1 && \
    # v4
    nvm install 4.6.2 && \
    nvm alias v4 4.6.2 && \
    # v5
    nvm install 5.12.0 && \
    nvm alias v5 5.12.0 && \
    # v6, lts
    nvm install 6.9.1 && \
    nvm alias v6 6.9.1 && \
    nvm alias lts 6.9.1 && \
    # v7, current
    nvm install 7.1.0 && \
    nvm alias current 7.1.0 && \
    nvm use lts

CMD ["nvm"]

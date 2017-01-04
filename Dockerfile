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
    echo \
    '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm use lts/*' \
    >> /etc/profile

RUN . $NVM_DIR/nvm.sh && \
    for v in \
    `seq 0 $(nvm ls-remote | tail -1 | sed 's/.*v\([0-9][0-9]*\)\..*/\1/')`\
    ; do nvm install $v; done

CMD ["nvm"]

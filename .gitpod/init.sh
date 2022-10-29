#!/usr/bin/env bash

set -o errexit
set -o nounset

if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./script.sh arg-one arg-two
This is an awesome bash script to make your life better.
'
    exit
fi

cd "$(dirname "$0")"
cd ..

install_deps() {
    sudo apt update
    yes | sudo apt install \
    git gcc g++ cmake \
    libjsoncpp-dev uuid-dev \
    openssl libssl-dev zlib1g-dev \
    postgresql-all
}

install_drogon() {
    WORK_PATH=./drogon
    cd $WORK_PATH
    git clone https://github.com/drogonframework/drogon
    cd drogon
    git submodule update --init
    mkdir build
    cd build
    cmake ..
    make && sudo make install
}

main() {
    install_deps
    install_drogon
}

main "$@"
#!/bin/sh

set -e
set -u

setup() {
    cat $HOME/.dotfiles/repolist.txt | ghq get -p --parallel
}

setup

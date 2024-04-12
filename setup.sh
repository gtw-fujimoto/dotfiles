#!/bin/sh

set -e
set -u

setup() {
     dotfiles=$HOME/.dotfiles

     has() {
         type "$1" > /dev/null 2>&1
     }

     symlink() {
         [ -e "$2" ] || ln -s "$1" "$2"
     }

     symlinkf() {
         ln -sf "$1" "$2"
     }

     if [ -d "$dotfiles" ]; then
         (cd "$dotfiles" && git pull --rebase)
     else
         git clone https://github.com/gtw-fujimoto/dotfiles "$dotfiles"
     fi

     ## timezone
     sudo timedatectl set-timezone Asia/Tokyo

     ## disk size
     sh $dotfiles/resize.sh 20

     has yum && sudo yum install -y jq tig git

     has git && symlinkf "$dotfiles/.gitconfig" "$HOME/.gitconfig"
     has git && symlinkf "$dotfiles/.bashrc" "$HOME/.bashrc"

     ## go
     which go && symlinkf "$dotfiles/.bash_profile" "$HOME/.bash_profile"
     source "$HOME/.bash_profile"
     which go && go install github.com/x-motemen/ghq@v1.5.0
     which go && go install github.com/peco/peco/cmd/peco@latest

    ## terraform
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
    sudo yum install -y terraform

     sh $dotfiles/setup_ssh.sh
}

setup
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
     ## sudo ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
     sudo timedatectl set-timezone Asia/Tokyo

     ## disk size
     sh $dotfiles/resize.sh 20

     has yum && sudo yum install -y jq tig git

     has git && symlinkf "$dotfiles/.gitconfig" "$HOME/.gitconfig"
     has git && symlinkf "$dotfiles/.git-completion.bash" "$HOME/.git-completion.bash"

     has git && symlinkf "$dotfiles/.bashrc" "$HOME/.bashrc"

     ## go
     wget https://go.dev/dl/go1.22.1.linux-amd64.tar.gz -O go.tgz
     tar -C $HOME -xzf go.tgz
     which go && symlinkf "$dotfiles/.bash_profile" "$HOME/.bash_profile"
     source "$HOME/.bash_profile"
     which go && go install github.com/x-motemen/ghq@latest
     ## export GO111MODULE=on
     which go && go install github.com/peco/peco/cmd/peco@latest
     ## maybe not use hub
     which go && go install github.com/github/hub@latest
     ## rain (amazon linux2 type: 53.medium)
     ##which go && go install github.com/aws-cloudformation/rain/cmd/rain@latest
     ## gh
     sudo yum-config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
     sudo yum install -y gh

     sudo pip install docker-compose

     sh $dotfiles/setup_ssh.sh
}

setup

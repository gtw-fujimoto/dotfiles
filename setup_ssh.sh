#!/bin/sh

KEY_NAME=`whoami`_at_`hostname`_on_`date --iso-8601="seconds"`
TYPE=ed25519
ssh-keygen -t $TYPE -C $KEY_NAME -f $HOME/.ssh/id_$TYPE -N ""
cat $HOME/.ssh/id_$TYPE.pub

echo "go to https://github.com/settings/keys"

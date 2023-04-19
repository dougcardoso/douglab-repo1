#!/bin/sh
git config --global user.name "dougcardoso"
git config --global user.email dougcardoso21@hotmail.com
ssh-keygen -t rsa -b 4096 -C "dougcardoso21@hotmail.com"
eval "$(ssh-agent -s)"
ssh-add /home/ansible/.ssh/id_rsa_git
git config --global credential.helper cache
ssh -T git@github.com
cat /home/ansible/.ssh/id_rsa_git.pub
echo "add this key in your github ssh keys in settings"


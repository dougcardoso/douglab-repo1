#!/bin/sh
eval "$(ssh-agent -s)"
ssh-add /home/ansible/.ssh/id_rsa_git
git config --global credential.helper cache
ssh -T git@github.com > git.access.log
git config --list >> git.access.log
cat git.access.log
chmod 755 git.access.log

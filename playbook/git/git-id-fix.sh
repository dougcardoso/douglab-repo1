#!/bin/bash

eval "$(ssh-agent -s)"
ssh-add /home/ansible/.ssh/id_rsa_git
git config --global credential.helper cache
ssh -T git@github.com


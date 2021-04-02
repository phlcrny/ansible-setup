#!/bin/bash
CLONE_DIR=/tmp/ansible-setup/
NAME=$(awk -F= '/^NAME/{print $2}' /etc/os-release | tr -d [:punct:])
rm -rf $CLONE_DIR && mkdir -p "$CLONE_DIR"
# Get the interactive prompts out of the way - no interruptions
echo -n "Run playbook with custom vars? (yes/no): "
read choice
if [ "$choice" == "y*" ]; then
    echo -n "Enter username (default: phil): "
    read username
    if [ "$choice" == "" ]; then
        username="phil"
    fi
    echo "User: $username"
    echo -n "Enter dotfiles repo (default: https://github.com/JohnDoe/dotfiles.git): "
    read dotfiles
    if [ "$dotfiles" == "" ]; then
        dotfiles="https://github.com/JohnDoe/dotfiles.git"
    fi
    echo "dotfiles: $dotfiles"
fi

if [[ $NAME == 'Ubuntu' ]]; then
    echo "Installing pre-reqs..." && \
    apt-get update > /dev/null 2> /dev/null && \
    apt-get install -y git curl software-properties-common > /dev/null 2> /dev/null && \
    echo "Installing ansible repository..." && \
    apt-add-repository --yes --update ppa:ansible/ansible > /dev/null 2> /dev/null && \
    echo "Installing ansible..." && \
    apt-get install -y ansible > /dev/null 2> /dev/null
else
    echo "No Ansible pre-req support for '$NAME' yet, install it yourself and try again."
fi

echo "Cloning playbook to $CLONE_DIR" && \
git clone https://github.com/phlcrny/ansible-setup.git $CLONE_DIR

if [ "$choice" == "y*" ]; then
    echo "Running playbook with custom variables: '$username' and '$dotfiles'" && \
    ansible-playbook "$CLONE_DIR/playbook.yml" -e "user=$username dotfiles_src=$dotfiles" && \
    echo "Reviewing creating cron jobs" && \
    crontab -l
else
    echo "Running playbook with defaults" && \
    ansible-playbook "$CLONE_DIR/playbook.yml" && \
    echo "Reviewing creating cron jobs" && \
    crontab -l
fi
#!/bin/bash
CLONE_DIR=/tmp/ansible-setup/
NAME=$(awk -F= '/^NAME/{print $2}' /etc/os-release | tr -d [:punct:])
rm -rf $CLONE_DIR && mkdir -p "$CLONE_DIR"
if [[ $NAME == 'Ubuntu' ]]
then
    echo "Installing pre-reqs..." && \
    apt-get update && apt-get install -y git curl software-properties-common && \
    echo "Installing ansible repository..." && \
    apt-add-repository --yes --update ppa:ansible/ansible && \
    echo "Installing ansible..." && \
    apt-get install -y ansible
fi

echo "Cloning playbook to $CLONE_DIR" && \
git clone https://github.com/phlcrny/ansible-setup.git $CLONE_DIR && \
echo "Running playbook" && \
ansible-playbook "$CLONE_DIR/playbook.yml" && \
crontab -l
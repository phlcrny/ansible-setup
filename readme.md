# Ansible Setup

An Ansible playbook to configure my Linux environments - inspiration (and some code re-use) from [John's version](https://github.com/jaspajjr/ansible-dev) which I contributed to.

## Getting Started

### Full

1. Ensure Ansible is installed, ideally from the Ansible repository or via pip (see [here](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html))
1. Clone this repository and ```cd``` to it

```bash
# To run it with default variables
ansible-playbook playbook.yml

# To see what it'll do
ansible-playbook playbook.yml --list-tasks --list-hosts

# To run it with custom values - recommended
ansible-playbook playbook.yml -e "user=johndoe dotfiles_src=https://github.com/JohnDoe/dotfiles.git"
```

### Quick Start

Quickly run and install from GitHub as below. Usual warnings and disclaimers apply.

```bash
curl https://raw.githubusercontent.com/phlcrny/ansible-setup/master/install.sh | sudo bash
```

## Troubleshooting

If Ansible complains about ```ansible.cfg``` being world-writable and therefore not a valid Ansible config, amend the permissions of the folder ``chmod 0755 //path/to/repo -R``

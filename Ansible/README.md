# Ansible

IT Automation Tool
Agentless FTW!!!
Tasks -> Playbook -> Roles 
Zero downtime or rolling updates


## Ansible Commands

```sh
ansible <host-pattern>
ansible-config
ansible-console
ansible-playbook
ansible-doc
ansible-galaxy <Package management sort of>
ansible-inventory
ansible-pull
ansible-vault
ansible -i <inventory> -u <user> <playbook> --ask-become-pass
```

## ansible.cfg 

1. current directory
2. home 
3. /etc/ansible

## Ansible Vault

Stores sensitive data

```sh
ansible -i <inventory> -u <user> -e \@file.yml <playbook> --ask-vault-pass --ask-become-pass
```

### Ansible Commands

```sh
ansible-vault create foo.yml
ansible-vault edit foo.yml
ansible-vault rekey foo.yml
ansible-vault encrypt foo.yml
ansible-vault decrypt foo.yml
ansible-vault view foo.yml
ansible-vault encrypt_string --vault-id <password_file> 'foobar' --name 'the_secret'
```
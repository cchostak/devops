# Chef

Uses a pure Ruby DSL. Uses Chef development Kit.

Client Server model.

## Chef testing tools

Cookstyle
Foodcritic
ChefSpec
InSpec
Test Kitchen

## Chef Client

Agent register and authenticate the node with the Chef Server
Build the node object
Sync cookbooks
Looking for exceptions and notifications

## Ctl commands

```sh
chef-server-ctl restore PATH_TO_BACKUP (options)
chef-server-ctl backup-recover
chef-server-ctl cleanse
chef-server-ctl gather-logs
chef-server-ctl ha-status
chef-server-ctl show-config
chef-server-ctl restart SERVICE_NAME
chef-server-ctl service-list
chef-server-ctl start SERVICE_NAME
chef-server-ctl status
chef-server-ctl stop SERVICE_NAME
chef-solo <Executes locally, without server>
```

## Knife

Manages nodes, cookbooks and recipes

```sh
knife cookbook generate COOKBOOK_NAME 
knife cookbook delete COOKBOOK_NAME 
knife cookbook download COOKBOOK_NAME 
knife cookbook list 
knife cookbook metadata 
knife cookbook show  COOKBOOK_NAME
knife cookbook upload  COOKBOOK_NAME

```
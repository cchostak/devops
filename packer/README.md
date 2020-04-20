# Packer

1. Create identical machine images

1.1 Download binary and place in /usr/local/bin (like every hashicorp product)
https://www.packer.io/downloads.html

```sh
mv ~/Downloads/packer /usr/local/bin
packer --version
```

2. Templates are JSON files

2.1 Builders -> What kind of image # Amazon AMI, HyperV
2.2 Description
2.3 Min_packer_version
2.4 post-processor -> Execute something after build # Amazon Import, Checksum, Docker Push, Docker Tag, Google Compute Image Exporter, Shell, Vagrant, vSphere
2.5 Provisioners -> Configuration manager of your choice # Ansible, Chef, Puppet, File, PowerShell, Shell
2.6 Variables

# Commands

```sh
packer build # Build in order
packer fix # Fix outdated parts
packer inspect # Reads a template and outputs the various components
packer validate # Check the template syntax

```

# Demo 

```sh
packer validate packer.json
packer build -var 'tag=0.0.1' packer.json # -var '' -var ''
docker run -dt -p 80:3000 --entrypoint "/usr/local/bin/node" la/express:0.0.1 /var/code/bin/www
```
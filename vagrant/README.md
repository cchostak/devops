# Download

https://www.vagrantup.com/downloads.html

https://www.vagrantup.com/downloads.html

CentOS 

```sh
yum install -y https://releases.hashicorp.com/vagrant/2.2.7/vagrant_2.2.7_x86_64.rpm
```

# Init -> ghost, scotch

```sh
vagrant --version
vagrant -h
vagrant init 
vagrant init -m # Stands for minimal
```

Configure yout box:

https://vagrantcloud.com/search

```sh
vagrant validate
vagrant up
vagrant status
vagrant ssh -c "ls /"
vagrant ssh # ssh vagrant@localhost -p 2222 -i ~/.vagrant.d/insecure_private_key
vagrant ssh-config
vagrant reload
vagrant halt
vagrant destroy
```

# Provision -> puppet_example

```sh
vagrant validate
vagrant up web
vagrant reload web --provision
vagrant up db
vagrant reload db --provision
```

# Vagrant Boxes

-> Version environments
-> Package eco-system

```sh
vagrant box add <ADDRESS>
vagrant box list
vagrant box outdated
vagrant box outdated --global
vagrant box prune
vagrant box remove <NAME>
vagrant box repackage <NAME> <PROVIDER> <VERSION>
vagrant box update
vagrant init <BOX NAME>
```

## Create a Box -> basebox

1. Download ISO

```sh
wget http://ports.ubuntu.com/dists/xenial/main/installer-powerpc/current/images/powerpc64/netboot/mini.iso

OR

curl http://ports.ubuntu.com/dists/xenial/main/installer-powerpc/current/images/powerpc64/netboot/mini.iso -o mini.iso
```

2. Run the image on VirtualBox

* Disable audio, usb
* Add port forwarding, SSH and others that you may need
* Place network as NAT
* Add the user vagrant when installing, and set the password to vagrant, 
* Remember of installing OpenSSH Server, 
* Set root password as vagrant, or, set the vagrant user to sudoers:

```sh
visudo 
vagrant ALL=(ALL) NOPASSWD:ALL

vi ~/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key

chmod 0600 ~/.ssh/authorized_keys
chown -R vagrant:vagrant ~/.ssh

vi /etc/ssh/sshd_config
AuthorizedKeysFile %h/.ssh/authorized_keys

service ssh restart
apt-get install -y gcc build-essential git linux-headers-$(uname -r) dkms
```

Install guest additions of VirtualBox


Do a zero out to fix fragmentation issues
```sh
dd if=/dev/zero of=/EMTPY bs=1M
rm -f /EMPTY
```

## Package the built image

```sh
vagrant package --base ubuntu64-base # The name of the Virtua Box VM
vagrant box add <A NAME> package.box # package.box is the output from above
```

# Box File Format

```sh
tar -xzvf package.box

```
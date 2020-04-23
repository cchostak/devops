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

# LAB -> AWS AMI

```sh
aws iam list-users
cat ~/.aws/credentials
aws s3api create-bucket --bucket packer-images-linux-cchostak  --region us-east-1
aws iot create-keys-and-certificate     --certificate-pem-outfile "myTest.cert.pem"     --public-key-outfile "myTest.public.key"     --private-key-outfile "myTest.private.key"
packer validate packer.json
packer build -var 'vpc_id=vpc-0cbb621d4c2034a84' -var 'subnet_id=subnet-0372d34e8cddc8074' packer.json
```

# LAB -> DOCKER

```sh
wget https://releases.hashicorp.com/packer/1.5.5/packer_1.5.5_linux_amd64.zip
unzip packer_1.5.5_linux_amd64.zip 
mv packer /usr/local/bin/
touch packerfile.json
packer validate packerfile.json
packer build packerfile.json
docker run -dt -p 80:3000 la/express:1.0 node /var/code/bin/www
docker ps
curl 127.0.0.1
```

# RUN

```sh
aws configure

terraform init
terraform plan
terraform apply

cat terraform.tfstate | jq -r '..|objects.public_ip' | sort | uniq

ssh -i "aws-ec2" ec2-user@3.83.106.238

OR

eval $(ssh-agent)
ssh-add aws-ec2
ssh ec2-user@3.83.106.238
```

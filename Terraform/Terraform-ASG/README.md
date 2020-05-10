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

# NOTE

The keys here (aws-ec2 and aws-ec2.pub) are not safe to use, so, keep that in mind if you use this in your environment.
##################################################################
# Data sources to get VPC, subnet, security group and AMI details
##################################################################
data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn2-ami-hvm-*-x86_64-gp2"
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}
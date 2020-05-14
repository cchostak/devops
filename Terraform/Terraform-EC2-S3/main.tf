# OUTPUT https://github.com/terraform-aws-modules/terraform-aws-vpc/blob/master/examples/complete-vpc/outputs.tf
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "DevOps-VPC"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  create_database_subnet_group = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  # VPC endpoint for S3
  enable_s3_endpoint = true

  # VPC endpoint for DynamoDB
  enable_dynamodb_endpoint = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

# OUTPUT https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/outputs.tf
module "ssh_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ssh-service"
  description = "Security group for user-service with custom ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["89.153.247.31/32", "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"] # curl -s ipinfo.io | jq -r '..|objects.ip' 
  egress_rules      = ["all-all"]
  ingress_rules = ["ssh-tcp", "all-icmp", "http-80-tcp", "https-443-tcp"] # https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/rules.tf
}

# OUTPUT https://github.com/terraform-aws-modules/terraform-aws-key-pair/blob/master/outputs.tf
module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "DevOpper" # ssh-keygen -y -e -f <private key>
  public_key = file("./aws-ec2.pub")
}

# OUTPUT https://github.com/terraform-aws-modules/terraform-aws-ec2-instance/blob/master/outputs.tf
module "ec2_public_access" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "DevOps"
  instance_count         = 1

  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = module.key_pair.this_key_pair_key_name
  monitoring             = true
  vpc_security_group_ids = [module.ssh_service_sg.this_security_group_id]
  subnet_ids             = module.vpc.public_subnets
  associate_public_ip_address = true
  user_data = file("./ssh_user_data")
  iam_instance_profile = module.iam_assumable_role.this_iam_role_name

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "iam" {
  source  = "terraform-aws-modules/iam/aws"
  version = "2.9.0"
}

# OUTPUT https://github.com/terraform-aws-modules/terraform-aws-iam/blob/master/modules/iam-assumable-role/outputs.tf
module "iam_assumable_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 2.0"

  trusted_role_arns = [
    "arn:aws:iam::307990089504:root"
  ]

  create_role = true

  role_name         = "custom"
  role_requires_mfa = false

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonCognitoReadOnly",
    "arn:aws:iam::aws:policy/AlexaForBusinessFullAccess",
    "arn:aws:iam::aws:policy/S3FullAccess",
  ]
}

# OUTPUT https://github.com/terraform-aws-modules/terraform-aws-s3-bucket/blob/master/outputs.tf
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "my-s3-bucket"
  acl    = "private"

  versioning = {
    enabled = true
  }

}
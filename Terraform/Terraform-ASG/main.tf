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
module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "DevOps"
  instance_count         = 2

  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = module.key_pair.this_key_pair_key_name
  monitoring             = true
  vpc_security_group_ids = [module.ssh_service_sg.this_security_group_id]
  subnet_ids             = module.vpc.private_subnets

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
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

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# AWS Auto Scaling Group (ASG) Terraform module
# https://github.com/terraform-aws-modules/terraform-aws-autoscaling
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"
  
  name = "service"

  # Launch configuration
  lc_name = "DevOps-lc"

  image_id        = data.aws_ami.amazon_linux.id
  instance_type   = "t2.micro"
  key_name = module.key_pair.this_key_pair_key_name
  user_data = file("./httpd_user_data")
  security_groups = [module.ssh_service_sg.this_security_group_id]
  termination_policies = [
  "ClosestToNextInstanceHour",
  "Default"
  ]
  suspended_processes	= [
    "AZRebalance"
  ]
  load_balancers  = [module.elb.this_elb_id]

  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "50"
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size = "50"
      volume_type = "gp2"
    },
  ]

  # Auto scaling group
  asg_name                  = "DevOps-asg"
  vpc_zone_identifier       = tolist(module.vpc.private_subnets)
  health_check_type         = "EC2"
  min_size                  = 0
  max_size                  = 10
  desired_capacity          = 2
  wait_for_capacity_timeout = 0

  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    }
  ]
}

######
# ELB
######
module "elb" {
  source = "terraform-aws-modules/elb/aws"

  name = "DevOps-elb"

  subnets         = module.vpc.public_subnets
  security_groups = [module.ssh_service_sg.this_security_group_id]
  internal        = false

  listener = [
    {
      instance_port     = "80"
      instance_protocol = "HTTP"
      lb_port           = "80"
      lb_protocol       = "HTTP"
    },
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}
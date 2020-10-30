module "ec2_webapp_az_a" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"
  name                   = "webapp"
  ami                    = "ami-07efac79022b86107"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["aws_security_group.webservers.id"]
  subnet_id              = module.webapp_vpc.private_subnets[0]
  tags = {
    Terraform   = "True"
    Environment = "Lab"
  }
}

# resource "aws_security_group" "alb_sg" {
#     name_prefix = "alb_sg"
#     vpc_id = module.vpc.vpc_id
 
#     ingress {
#         from_port = 80
#         to_port = 80
#         protocol = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }
# }

# resource "aws_security_group" "webservers" {
#     name_prefix = "webservers"
#     vpc_id = module.vpc.vpc_id
 
#     ingress {
#         from_port = 80
#         to_port = 80
#         protocol = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#         #security_groups = ["aws_security_group.alb_sg.id"]
#     }
# }

module "ec2_webapp_az_b" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"
  name                   = "webapp"
  ami                    = "ami-07efac79022b86107"
  instance_type          = "t2.micro"
  #key_name               = "user1"
  #monitoring             = true
  vpc_security_group_ids = ["module.webservers.this_security_group_id"]
  subnet_id              = module.webapp_vpc.private_subnets[1]
  tags = {
    Terraform   = "True"
    Environment = "Lab"
  }
}
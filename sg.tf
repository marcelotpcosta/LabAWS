module "sg-alb" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = "sg-alb"
  description = "Security group for alb"
  vpc_id      = module.webapp_vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp"]
  egress_rules        = ["all-all"]
}
module "webservers" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = "webservers"
  description = "Security group for webservers"
  vpc_id      = module.webapp_vpc.vpc_id
   ingress_with_source_security_group_id = [
   {
       rule                     = "alb"
       source_security_group_id = module.sg-alb.this_security_group_id
    },
    {
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      description              = "ALB"
      source_security_group_id = module.sg-alb.this_security_group_id
    },
  ]
}
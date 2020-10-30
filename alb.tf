module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"
  
  name = "webapp-alb"
  load_balancer_type = "application"
  vpc_id             = module.webapp_vpc.vpc_id
  subnets            = module.webapp_vpc.public_subnets
  security_groups    = ["aws_security_group.alb_sg.id"]
  
  target_groups = [
    {
      name_prefix      = "HTTP"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]
  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
  tags = {
    Terraform   = "True"
    Environment = "Lab"
  }
}

resource "aws_lb_target_group_attachment" "ec2_az_a" {
  target_group_arn = "${join(",", module.alb.target_group_arns)}"
  target_id        = "${join(",", module.ec2_webapp_az_a.id)}"
  port             = 80
}

resource "aws_lb_target_group_attachment" "ec2_az_b" {
  target_group_arn = "${join(",", module.alb.target_group_arns)}"
  target_id        = "${join(",", module.ec2_webapp_az_b.id)}"
  port             = 80
}
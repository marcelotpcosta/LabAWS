variable "account" {
 type = "string"
 description = "AWS account id"
 default = "XXXXXX" #marcelo's account
}

module "webapp_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.47.0"

  name = "webapp_vpc"
  cidr = "10.10.0.0/16"
  enable_dns_hostnames = true
  azs                  = ["us-east-2a", "us-east-2b"]
  private_subnets      = ["10.10.0.0/24", "10.10.1.0/24"]
  public_subnets       = ["10.10.2.0/24", "10.10.3.0/24"]
  enable_nat_gateway   = true
}
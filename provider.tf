provider "aws" {
 allowed_account_ids = [var.account] #marcelo's account
 region = "us-east-2"
}
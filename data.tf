#data block to fetch latest ami of linux/ubuntu os in primary region
data "aws_ami" "linux_Server_pr" {
  owners             = ["amazon"]
  most_recent        = true
  include_deprecated = false

  filter {
    name   = "name"
    values = ["ubuntu-pro-fips-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#data block to fetch vpc
data "aws_vpc" "qa_vpc" {
  id = var.vpc_id
}

data "aws_subnet" "selected" {
  id = var.subnet_id
}

data "aws_security_group" "selected" {
  id = var.security_group
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
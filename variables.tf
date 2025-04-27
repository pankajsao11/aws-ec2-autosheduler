variable "region" {
  description = "Region Name"
  default     = "us-east-1"
}

variable "lambda_function_name" {
  description = "function name"
  default     = "ec2-scheduler"
}

variable "vpc_id" {
  default = "vpc-0814fe9807b56b460"
}

variable "subnet_id" {
  default = "subnet-0afabf70c285d0e84"
}

variable "security_group" {
  default = "sg-0be105092a94b5a64"
}
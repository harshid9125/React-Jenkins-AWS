variable "subnet_ids" {
  type = list
}

variable "vpc_id" {}

variable "public_subnet_az1" {}

variable "public_subnet_az2" {}

variable "alb_security_group_id" {
  type = list(string)
}
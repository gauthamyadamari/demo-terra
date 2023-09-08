variable "tg_name" {
  default = "myapp-tg"
}

variable "tg_port" {
  default = "80"
}

variable "targrp_count" {
  default = 2
}

variable "subnet_ids" {
  
}

variable "tg_protocol" {
  default = "HTTP"
}

variable "vpc_id" {}

variable "alb_name" {
  default = "my-alb"
}

variable "alb_ingress_rules" {
  type = map(object({
    port        = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
}

variable "instance_ids" {
  type    = list(string)
  default = []
}

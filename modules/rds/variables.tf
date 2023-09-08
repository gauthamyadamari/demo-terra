variable "sub_ids" {
}

variable "storage" {
  default = 20
}
variable "db_name" {
  default = "manudb"
}
variable "username" {
  default = "mamidi"
}
variable "password" {
  default = "mamidi1234"
}
variable "vpc_id" {
}
variable "rds_ingress_rules" {
  type = map(object({
    port            = number
    protocol        = string
    cidr_blocks     = list(string)
    description     = string
    security_groups = list(string)
  }))
}
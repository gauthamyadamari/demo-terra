module "jhc_vpc" {
  source = "./modules/networking"
  vpc_tags = {
    Name = "jhc-app"
  }
}

module "manu_rds" {
  source  = "./modules/rds"
  sub_ids = module.jhc_vpc.pri_sub_ids
  vpc_id  = module.jhc_vpc.vpc_id
  rds_ingress_rules = {
    "app1" = {
      port            = 3306
      protocol        = "tcp"
      cidr_blocks     = []
      description     = "allow ssh within organization"
      security_groups = [module.webapp.security_group_id]
    }
  }
}

# module "exmple_zone" {
#   source = "./modules/route53"
#   vpc_id = module.jhc_vpc.vpc_id
# }

module "myappalb" {
  source = "./modules/alb"
  vpc_id = module.jhc_vpc.vpc_id
  subnet_ids = module.jhc_vpc.pub_sub_ids
  alb_ingress_rules = {
    "80" = {
      port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "allow 80 everywhere"
     }
  }
    instance_ids = module.webapp.instance_ids
 }

 module "webapp" {
 source = "./modules/ec2"
  ami = "ami-051f7e7f6c2f40dc1"
  vpc_id = module.jhc_vpc.vpc_id
  subnet_ids = module.jhc_vpc.pub_sub_ids
  
  web_ingress_rules = {
    "80" = {
      port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description="allow http"
    }
    "ssh" = {
      port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "allow ssh"
    }
  }
}
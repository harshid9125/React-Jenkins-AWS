provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

module "vpc" {
  source                       = "./modules/vpc"
  vpc_cidr                     = "10.0.0.0/16"
  public_subnet_az1_cidr       = "10.0.1.0/24"
  public_subnet_az2_cidr       = "10.0.128.0/24"
  private_data_subnet_az1_cidr = "10.0.12.0/24"
  private_data_subnet_az2_cidr = "10.0.18.0/24"
}

module "application_load_balancer" {
  source                = "./modules/lb"
  alb_security_group_id = module.vpc.alb_security_group_id
  public_subnet_az1_id  = module.vpc.public_subnet_az1_id
  public_subnet_az2_id  = module.vpc.public_subnet_az2_id
  vpc_id                = module.vpc.vpc_id
  certificate_arn       = "arn:aws:acm:us-east-1:222558187691:certificate/f6de8e54-aea4-4395-9986-70a976a2b8a1"
}

# module "rds" {
#   source            = "./modules/rds"
#   subnet_ids        = [module.vpc.public_subnet_az1_id, module.vpc.public_subnet_az2_id]
#   public_subnet_az1 = module.vpc.public_subnet_az1_id
#   public_subnet_az2 = module.vpc.public_subnet_az2_id
# }

module "kubernetes" {
  source                = "./modules/eks"
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = [module.vpc.public_subnet_az1_id, module.vpc.public_subnet_az2_id]
  public_subnet_az1     = module.vpc.public_subnet_az1_id
  public_subnet_az2     = module.vpc.public_subnet_az2_id
  alb_security_group_id = [module.vpc.alb_security_group_id]
}
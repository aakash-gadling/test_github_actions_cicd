provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../../modules/vpc"
}

module "ecr" {
  source = "../../modules/ecr"
}

module "alb" {
  source     = "../../modules/alb"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets
}

module "ecs" {
  source              = "../../modules/ecs"
  vpc_id              = module.vpc.vpc_id
  private_subnets     = module.vpc.private_subnets
  alb_listener_arn    = module.alb.listener_arn
  target_group_arns  = module.alb.target_group_arns
  ecr_repo_urls      = module.ecr.repo_urls
  services            = var.services
}

module "rds" {
  source          = "../../modules/rds"
  private_subnets = module.vpc.private_subnets
}

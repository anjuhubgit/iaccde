module "vpc" {
  source = "../modules/vpc"
  env = var.env
  vpc_cidr = "10.0.0.0/16"
  public_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets_cidr = ["10.0.101.0/24", "10.0.102.0/24"]
  
  
}

module "ec2" {
  source = "https://github.com/anjuhubgit/iaccde.git/modules/ec2"
  ami_id = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  keypair_name = "devkey"
  env = var.env
  subnet_id = module.vpc.public_subnet_ids[0]
  #vpc_id = module.vpc.vpc_id
}

module "secrets_manager" {
  source = "https://github.com/anjuhubgit/iaccde.git/modules/secrets_manager"
  env = var.env
  db_password = var.db_password
}

module "rds" {
  source = "https://github.com/anjuhubgit/iaccde.git/modules/rds"
  env = var.env
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.private_subnet_ids
  instance_class        = "db.t3.micro"
  db_password           = module.secrets_manager.db_password
  app_security_group_id = module.ec2.ec2-sg-id
  
}
module "s3_assets" {
  source       = "https://github.com/anjuhubgit/iaccde.git/modules/s3"
  env = var.env
  bucket_name  = "dev-app-assets"
}

module "ecr_repo" {
  source  = "https://github.com/anjuhubgit/iaccde.git/modules/ecr"
  env     = var.env
  repo_name  = "dev-web-app"
}

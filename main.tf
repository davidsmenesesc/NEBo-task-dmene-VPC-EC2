terraform {
  backend "remote" {
    organization = "davidsmenesesc"
    workspaces {
      name = "NEBo-task-dmene-VPC-EC2"
    }
  }
}

provider "aws"{
    region =  var.region
}
module "Network" {
  source = "./Networking"
  # vpc_cidr_block = "10.0.0.0/16"
  # subnet_cidr_blocks = ["10.0.1.0/17", "10.0.128.0/17"]
}
module "EC2"{
  source = "./EC2"
  vpc_id = module.networking.vpc_id
  subnet_ids = module.networking.subnet_ids
}
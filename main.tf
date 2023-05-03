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
}
module "EC2"{
  source = "./EC2"
  subnet_ids_pub = module.Network.subnet_id_pub
  subnet_ids_priv = module.Network.subnet_id_priv 
  pub_sg = module.Network.pub_sg
  priv_sg = module.Network.priv_sg
  vpc_id= module.Network.vpc_id
}
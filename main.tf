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
  subnet_ids_pub = module.Network.subnet_ids_pub
  subnet_ids_priv = module.Network.subnet_ids_priv 
}
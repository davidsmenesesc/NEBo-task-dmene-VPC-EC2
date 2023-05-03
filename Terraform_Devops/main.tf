# terraform {
#     cloud {
#         organization = "davidsmenesesc"
#         workspaces {
#         name = ""
#         }
#     }
# }
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
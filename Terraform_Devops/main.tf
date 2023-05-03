provider "aws"{
    region =  var.region
}
module "Network" {
  source = "./Networking"
}
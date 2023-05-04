variable "region" {
  description = "AWS-region"
  type = string
  default = "us-east-1"
}
variable "subnet_ids_pub" {
  description = "List of IDs for the subnets to launch instances in"
  type        = string
}
variable "subnet_ids_priv" {
  description = "List of IDs for the subnets to launch instances in"
  type        = string
}
variable "vpc_id" {
  description = "List of IDs for the subnets to launch instances in"
  type        = string
}
variable "pub_sg" {
  description = "List of IDs for the subnets to launch instances in"
  type        = string
}
variable "priv_sg" {
  description = "List of IDs for the subnets to launch instances in"
  type        = string
}

variable "region" {
  description = "AWS-region"
  type = string
  default = "us-east-1"
}
variable "VPC_CIDR" {
  description = "VPC_CIDR"
  type = string
  default = "10.0.0.0/16"
}
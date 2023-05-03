variable "region" {
  description = "AWS-region"
  type = string
  default = "us-east-1"
}
variable "subnet_ids" {
  description = "List of IDs for the subnets to launch instances in"
  type        = list(string)
}
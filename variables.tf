# Variable for VPC Cidr Range
variable "vpc-Cidr" {
  type = string
  default = "10.0.0.0/16"
}

# Give project a name
variable "project" {
  type = string
  default = "apache"
}

# Launch Template AMI
variable "ami" {
  type = string
  default = "ami-05c13eab67c5d8861"
}
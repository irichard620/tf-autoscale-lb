## Get access key from tfvars file
variable "aws_access_key" {}

## Get secret key from tfvars file
variable "aws_secret_key" {}

variable "region" {
    description = "Define region to use"
    default = "us-east-2"
}

data "aws_availability_zones" "available" {
    state = "available"
}

variable "instance_type" {
    description = "Use nano instance to speed up and reduce cost"
    default = "t2.nano"
}

variable "ami" {
    description = "Define image to use in AWS - Linux EBS"
    default = "ami-0b00e7f461c40ed19"
}

variable "keypair_path" {
    description = "Path to SSH keypair for instance"
    default = "/Users/ianrichard/tf_keypair.pem"
}
variable "keypair_name" {
    description = "Key pair for our EC2 instances"
    default = "tf_keypair"
}

#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-2df66d3b
#
# Your subnet ID is:
#
#     subnet-fe40a9a4
#
# Your security group ID is:
#
#     sg-4cc10432
#
# Your Identity is:
#
#     testing-elk
#

terraform {
  backend "atlas" {
    name = "sbasyal/train"
  }
}


variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "region" {
  default = "us-east-1"
}

variable "num" {
  default = "3"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "web" {
  # ...
  count = 3
  ami                    = "ami-2df66d3b"
  subnet_id              = "subnet-fe40a9a4"
  vpc_security_group_ids = ["sg-4cc10432"]
  instance_type          = "t2.micro"

  tags {
    "Identity" = "testing-elk"
    "Name"     = "sabin-testing-elk-${count.index+1}/${var.num}"
  }
}

  output "PublicIP" {
    value = ["${aws_instance.web.*.public_ip}"]
  }

  output "PublicDNS" {
    value = ["${aws_instance.web.*.public_dns}"]
  }

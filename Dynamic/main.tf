provider "aws" {
  region = "us-west-2"
}

   variable "ingressrules" {
      type =list(number)
      default = [80,443]
   }
   
   variable "egressrules" {
    type = list(number)
    default = [80,443,8080,53,25,9000,8081,3306]
   }

resource "aws_instance" "web" {
  ami           = "ami-0df24e148fdb9f1d8"
  instance_type = "t2.micro"
  tags = {
      Name = "Time"
  }
  security_groups = [aws_security_group.webtraffic.name]
}

resource "aws_security_group" "webtraffic" {
    name = "Allow HTTPS"

    dynamic "ingress" {
      iterator = port
      for_each = var.ingressrules
        content {
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }

    dynamic "egress" {
      iterator = port
      for_each = var.egressrules
        content {
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }
}
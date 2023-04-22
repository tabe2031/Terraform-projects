provider "aws" {
    region = "us-west-2"
}

resource "aws_vpc" "test" {
    cidr_block = "10.0.0.0/16"
  tags = { 
    Name = "first"
  }
}
output "vpc_id"{
    value = aws_vpc.test.id
}
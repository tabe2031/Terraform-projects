provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "web" {
  ami           = "ami-0df24e148fdb9f1d8"
  instance_type = "t2.micro"
  tags = {
      Name = "Time"
  }
}

resource "aws_eip" "elasticip" {
  instance = aws_instance.web.id
  vpc      = true
}

output "EIP" {
    value = aws_eip.elasticip.public_ip
}

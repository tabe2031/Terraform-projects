terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

#configure Provider
provider "aws" {
  region = var.region
}

#1 aws_vpc
resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/22"
}

#2 aws_internet_gateway 
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.test.id

  /*tags = {
    Name = "main"
  }*/
}

#3 aws_route_table 
resource "aws_route_table" "example" {
  vpc_id = aws_vpc.test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Test"
  }
}

#4 aws_subnet
resource "aws_subnet" "web" {
  vpc_id            = aws_vpc.test.id
  cidr_block        = "10.0.3.0/24" #254 IP's
  availability_zone = "us-west-2b"

  tags = {
    Name = "Web"
  }
}

/*resource "aws_subnet" "App" {
  vpc_id     = aws_vpc.test.id
  cidr_block = "10.0.2.0/24"  #254 IP's

  tags = {
    Name = "App"
  }
}

resource "aws_subnet" "Db" {
  vpc_id     = aws_vpc.test.id
  cidr_block = "10.0.0.0/23"  #510 IP's

  tags = {
    Name = "Db"
  }
}*/

#5  aws_route_table_association
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.web.id
  route_table_id = aws_route_table.example.id
}

/*resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.web.id
  route_table_id = aws_route_table.bar.id
}
 
 resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.web.id
  route_table_id = aws_route_table.bar.id
}*/

#6 Create a security group and attach port 22,80,443
resource "aws_security_group" "web" {
  name = "allow_web-traffic"
  #description = "Allow TLS inbound traffic"
  vpc_id = aws_vpc.test.id

  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
      # description = "allow inbound traffic"
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Web-Traffic"
  }
}

#7 Creat a network interface with an ip in the subnet that was created in staep 4
resource "aws_network_interface" "test" {
  subnet_id       = aws_subnet.web.id
  private_ips     = ["10.0.3.40"]
  security_groups = [aws_security_group.web.id]

}

#8 assign an elastic ip to the network interface created in step 7

resource "aws_eip" "lb" {
  network_interface         = aws_network_interface.test.id
  vpc                       = true
  associate_with_private_ip = "10.0.3.40"
  depends_on                = [aws_internet_gateway.gw]
}

#9 provision a server/Instance and install/enable httpd
resource "aws_instance" "web" {
  #ami           = data.aws_ami.ubuntu.id
  ami = "ami-0db245b76e5c21ca1"
  instance_type = "t2.micro"
  key_name      = "luck"
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.test.id
  }
  tags = {
    Name = "Web"
  }
}

output "instance_id" {
  value = aws_instance.web.id
}
#allow web traffic(httpd,https) for our instance
/*resource "aws_security_group" "vpc-web" {
  name        = "allow_vpc-web"
  description = "Allow 80,443 inbound traffic"
  #vpc_id      = aws_vpc.main.id


  ingress {
    description = "allow port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "vpc-web"
  }
}

resource "aws_security_group" "vpc-ssh" {
  name        = "allow_vpc-ssh"
  description = "Allow 22 inbound traffic"
  #vpc_id      = aws_vpc.main.id


  ingress {
    description = "allow port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "vpc-ssh"
  }
}*/



resource "aws_security_group" "vpc-SG" {
  name = "allow Traffic"
  #description = "Allow inbound and outbound traffic"
  #vpc_id      = aws_vpc.main.id


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

  dynamic "egress" {
    iterator = port
    for_each = var.egressrules
    content {
      #description = "allow outbound traffic"
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "vpc-SG"
  }
}
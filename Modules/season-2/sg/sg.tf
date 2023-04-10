variable "ingressrules" {
  description = "this will be for the inbound rule for  web"
  type        = list(number)
  default     = [22, 80, 443, 8080]
}


variable "egressrules" {
  description = "this will be for the outbound rule for web"
  type        = list(number)
  default     = [22, 25, 53, 80, 443, 3306, 8080]
}

output "season2-SG" {
  value = aws_security_group.season2-SG.name
}


resource "aws_security_group" "season2-SG" {
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
    Name = "season2-SG"
  }
}
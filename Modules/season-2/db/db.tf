resource "aws_instance" "db" {
  ami = data.aws_ami.linux1.id
  #security_groups = [module.sg.season2-SG]
  
  instance_type = "t2.micro"
  
   tags = {
    Name  = "Db-Server"
  }
}

output "PrivateIP" {
   value = aws_instance.db.private_ip
}
resource "aws_instance" "web" {
  ami = data.aws_ami.linux1.id
  instance_type  = "t3.micro"
  security_groups = [module.sg.season2-SG]
   key_name  = "luck"
  user_data   = file("./web/script.sh")

   tags = {
    Name  = "web-Server"
  }
}

/*output "pub_ip" {
  value = module.eip.PublicIP
}*/

module "eip" {
  source = "../eip"
  instance_id = aws_instance.web.id
}

module "sg" {
  source = "../sg"
}
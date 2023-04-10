resource "aws_instance" "ec2" {
  ami = data.aws_ami.linux1.id
  instance_type          = var.instance_type
  #instance_type = var.instance_type_list[0] #for list
  #instance_type           = var.instance_type_map["dev"] #for map       
 #user_data              = file("${path.module}/app1-install.sh")
  #vpc_security_group_ids = [aws_security_group.vpc-SG.name]
 # key_name               = var.key-pair
  #vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  #count = 3

  tags = {
    #Name = "First-EC2-${count.index}"
    Name  = var.ec2name 
  }
}
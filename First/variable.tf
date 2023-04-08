variable "region" {
  description = "this is for my aws_region"
  type        = string
  default     = "us-west-2"
}
/*
variable "instance_type" {
  description = "this is for my aws_instance"
  type        = string
  default     = "t2.micro"
}
*/
variable "instance_type_list" {
  description = "this is for my aws_instance in list format where we will use index[0],[1],[2] to call the type of instance we intend to create.  "
  type        = list(string)
  default     = ["t2.micro", "t2.nano", "t2.meduim", "t3.micro"]
}

variable "instance_type_map" {
  description = "this for my instance whose value is a map format that can be chosen in refrence to the department required"
  type        = map(any)
  default = {
    "dev"  = "t2.medium"
    "qa"   = "t3.micro"
    "prod" = "t2.large"
  }
}

/*
variable "ami" {
  description = "this is for my aws_ami"
  type        = string
  default     = "ami-07f3ef11ec14a1ea3" #they are region specific so make sure you chose from the specific region you intend to work with.
}
*/

variable "key-pair" {
  description = "this will be used to ssh into the server"
  type        = string
  default     = "luck"
}

variable "ingressrules" {
  description = "this will be for the inbound rule of our instanc1"
  type        = list(number)
  default     = [22, 80, 443, 8080]
}

variable "egressrules" {
  description = "this will be for the outbound rule of instanc1"
  type        = list(number)
  default     = [22, 25, 53, 80, 443, 3306, 8080]
}
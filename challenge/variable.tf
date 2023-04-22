variable "name" {
    default = "tabe"
    description = "this will be for names we refrence in the name of the S3"
}

variable "region" {
  type    = string  #list(string)
  #default = ["us-west-1", "us-west-2", "us-east-1"]
}
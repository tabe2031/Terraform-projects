variable "ingressrules" {
  type    = list(number)
  default = [22, 80, 443]
}

variable "region" {
  default = "us-west-2"
}
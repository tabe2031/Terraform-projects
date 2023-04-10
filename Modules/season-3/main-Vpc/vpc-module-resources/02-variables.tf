#Region Variable
variable "region" {
  description = "this is for my aws_region"
  type        = string
  default     = "us-west-2"
}

#Environmenatal Variable
variable "environment" {
  description = "this is Env "
  type        = string
  default     = "dev"
}

# Division Variable
variable "business_division" {
  description = "this is for my aws_re"
  type        = string
  default     = "SAP"
}
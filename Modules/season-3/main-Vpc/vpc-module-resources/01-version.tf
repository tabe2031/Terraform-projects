terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 3.0" # Optional but recommended in production
    }
  }
}

provider "aws" {
  profile = "default" #AWS Credentials profile in your local desktop terminal $HOME/.aws/credentials
  region  = var.region

}
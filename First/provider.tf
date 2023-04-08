terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0" # Optional but recommended in production
    }
  }
}

provider "aws" {
  #profile = default #AWS Credentials profile in your local desktop terminal $HOME/.aws/credentials
  region = var.region
}

#to reset my Aws ACCESS and SECRET kEY, RUN THIS COMMAND IN YOUR TERMINAL. for var in AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_SECURITY_TOKEN ; do eval unset $var ; done
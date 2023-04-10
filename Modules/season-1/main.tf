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
  profile = "default" #AWS Credentials profile in your local desktop terminal $HOME/.aws/credentials
  region  = "us-west-2"

}

module "ec2module" {
  source  = "./ec2"
  ec2name = "new-ec2"
}

output "module_output" {
  value = module.ec2module.instance_id
}
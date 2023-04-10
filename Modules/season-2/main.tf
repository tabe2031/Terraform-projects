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

module "db" {
  source = "./db"
}

module "web" {
  source = "./web"
}

output "PrivateIP" {
  value = module.db.PrivateIP
}

/*output "publicIP" {
  value = module.web.pub_ip
}*/
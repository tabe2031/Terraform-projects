#Terrform block
/*terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}*/

provider "aws" {
    region = var.region
}

resource "random_integer" "num" {
    max = 100
    min = 1
}

 /* resource "aws_s3_bucket" "example" {
  bucket = "Bootcamp30-${random.num.result}-tabs"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}*/
 /*resource "random_pet" "pet_name" {
    prefix = "bootcamp"
    length = 2
}*/

 resource "aws_s3_bucket" "backend" { 
    bucket = "bootcamp30-${random_integer.num.result}-${var.name}"
    #bucket = random_pet.pet_name.id
 }

resource "aws_kms_key" "key-1" {
  description             = "KMS key 1"
  deletion_window_in_days = 10
}

resource "aws_kms_key" "key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

/*resource "aws_s3_bucket" "mybucket" {
  bucket = "mybucket"
}*/ 

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.backend.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.key-1.arn
      sse_algorithm     = "aws:kms"
    }
  }
}



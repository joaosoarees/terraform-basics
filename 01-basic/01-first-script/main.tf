terraform {
  required_version = "1.6.3"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.24.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "terraform"
}

resource "aws_s3_bucket" "terraform-test-bucket" {
  bucket = "terraform-test-bucket-4218749812"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_ownership_controls" "terraform-test-bucket" {
  bucket = aws_s3_bucket.terraform-test-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "terraform-test-bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.terraform-test-bucket]

  bucket = aws_s3_bucket.terraform-test-bucket.id
  acl    = "private"
}
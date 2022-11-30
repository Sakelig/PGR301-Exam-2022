terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.40.0"
    }
  }
  backend "s3" {
    bucket = aws_s3_bucket.analyticsbucket
    key    = "1048/terraform.state"
    region = "eu-west-1"
  }
}

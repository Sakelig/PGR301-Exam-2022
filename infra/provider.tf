terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.40.0"
    }
  }
  backend "aws_s3_bucket" {
    bucket = "analytics-${var.candidate_id}"
      key    = "${var.candidate_id}/terraform.state"
      region = "eu-west-1"
  }
}

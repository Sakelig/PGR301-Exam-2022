terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.40.0"
    }
  }
  backend "s3" {
      bucket = "pgr301-exam-2022-terraform-state"
      key    = "1048/cloudwatch.state"
      region = "eu-north-1"
    }

}

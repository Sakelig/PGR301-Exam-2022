resource "aws_s3_bucket" "analyticsbucket" {
  bucket = "analytics-${var.candidate_id}"
  region = "eu-west-1"
}

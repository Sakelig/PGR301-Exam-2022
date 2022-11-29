resource "aws_s3_bucket" "analyticsbucket" {
  bucket = "analytics-${var.candidate_id}"
  key    = "${var.candidate_id}/terraform.state"
  region = "eu-west-1"
}

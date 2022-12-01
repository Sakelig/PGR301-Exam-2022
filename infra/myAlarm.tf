
resource "aws_cloudwatch_metric_alarm" "zerosum" {
  alarm_name                = "carts-over-5"
  namespace                 = var.candidate_id
  metric_name               = "carts.value"

  comparison_operator       = "GreaterThanThreshold"
  threshold                 = "5"
  evaluation_periods        = "2"
  period                    = "320"

  statistic                 = "Maximum"

  alarm_description         = "This alarm goes off as soon as the total amount of carts exceeds 5 "
  insufficient_data_actions = []
  alarm_actions       = [aws_sns_topic.user_updates.arn]
}

resource "aws_sns_topic" "user_updates" {
  name = var.candidate_id
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.user_updates.arn
  protocol  = "email"
  endpoint  = var.candidate_email
}

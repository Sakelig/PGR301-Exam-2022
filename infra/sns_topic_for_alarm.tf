resource "aws_cloudwatch_metric_alarm" "zerosum" {
  alarm_name                = "carts-over-5-${var.candidate_id}"
  namespace                 = "1048"
  metric_name               = "carts.value"

  comparison_operator       = "GreaterThanThreshold"
  threshold                 = "5"
  evaluation_periods        = "2"
  period                    = "180"

  statistic                 = "Maximum"

  alarm_description         = "This alarm goes off as soon as the total amount of carts exceeds 5 "
  insufficient_data_actions = []
  alarm_actions       = [aws_sns_topic.alarms.arn]
}

resource "aws_sns_topic" "alarms" {
  name = "alarm-topic-${var.candidate_id}"
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.alarms.arn
  protocol  = "email"
  endpoint  = var.candidate_email
}

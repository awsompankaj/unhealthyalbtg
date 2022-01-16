resource "aws_sns_topic" "user_updates" {
  name = "Notifications_for_ungoliant_team"
}


resource "aws_sns_topic_subscription" "user_updates_sns_target" {
  topic_arn = aws_sns_topic.user_updates.arn
  protocol  = "email"
  endpoint  = "email id"
}

resource "aws_cloudwatch_metric_alarm" "alb_healthyhosts" {
  alarm_name          = "Unhealthy Jenkins Target Groups"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = "300"
  statistic           = "Sum"
  threshold           =  3
  alarm_description   = "Unhealthy Jenkins Target Groups"
  actions_enabled     = "true"
  alarm_actions       = [aws_sns_topic.user_updates.arn]
  ok_actions          = [aws_sns_topic.user_updates.arn]
  dimensions = {
    TargetGroup  = "targetgroup/My-app-tg/41d3a7cc48b31463"
    LoadBalancer = "loadbalancer/app/Myapp-lb/bddf2c8a4043092b"
  }
 }


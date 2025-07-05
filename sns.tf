resource "aws_sns_topic" "ec2_tpc" {
  name       = "ec2-sns"
  fifo_topic = false
}

resource "aws_sns_topic_subscription" "ec2_subscription" {
  topic_arn = aws_sns_topic.ec2_tpc.arn
  protocol  = "email"
  endpoint  = "pankajsao11@gmail.com"
}

#cloudwatch event rule

resource "aws_cloudwatch_event_rule" "ec2_stop" {
  name        = "ec2-instance-stopped"
  description = "Trigger when EC2 is stopped"
  event_pattern = jsonencode({
    "source" : ["aws.ec2"],
    "detail-type" : ["EC2 Instance State-change Notification"],
    "detail" : {
      "state" : ["stopped"]
    }
  })
}

resource "aws_cloudwatch_event_target" "send_sns" {
  rule      = aws_cloudwatch_event_rule.ec2_stop.name
  target_id = "sendToSNS"
  arn       = aws_sns_topic.ec2_tpc.arn
}
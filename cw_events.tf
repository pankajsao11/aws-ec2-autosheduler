resource "aws_cloudwatch_event_rule" "start_event" {
  name                = "start-ec2-daily"
  schedule_expression = "cron(0 8 * * ? *)"
}

resource "aws_cloudwatch_event_target" "start_target" {
  rule = aws_cloudwatch_event_rule.start_event.name
  arn  = aws_lambda_function.ec2_lambda.arn
  input = jsonencode({
    action = "start"
  })
}

resource "aws_lambda_permission" "start_permission" {
  statement_id  = "AllowExecutionFromCWStart"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ec2_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.start_event.arn
}

resource "aws_cloudwatch_event_rule" "stop_event" {
  name                = "stop-ec2-daily"
  schedule_expression = "cron(0 22 * * ? *)"
}

resource "aws_cloudwatch_event_target" "stop_target" {
  rule = aws_cloudwatch_event_rule.stop_event.name
  arn  = aws_lambda_function.ec2_lambda.arn
  input = jsonencode({
    action = "stop"
  })
}

resource "aws_lambda_permission" "stop_permission" {
  statement_id  = "AllowExecutionFromCWStop"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ec2_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.stop_event.arn
}
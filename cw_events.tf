resource "aws_iam_role" "scheduler_role" {
  name = "eventbridge-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "scheduler.amazonaws.com"
        },
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = data.aws_caller_identity.current.account_id
          }
        }
      }
    ]
  })

  tags = {
    Role_usage = "Permission for Eventbridge scheduler"
  }
}

resource "aws_iam_role_policy_attachment" "event_role_attachment" {
  role       = aws_iam_role.scheduler_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# Scheduled Start
resource "aws_scheduler_schedule" "start_schedule" {
  name       = "start-ec2-schedule"
  description = "AutoStart of EC2 instances"
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "cron(35 23 * * ? *)" # 8 AM daily
  schedule_expression_timezone = "Asia/Kolkata"

  target {
    arn      = aws_lambda_function.ec2_lambda.arn
    role_arn = aws_iam_role.scheduler_role.arn

    input = jsonencode({
      action = "start"
    })
  }
}

# Scheduled Stop
resource "aws_scheduler_schedule" "stop_schedule" {
  name       = "stop-ec2-schedule"
  description = "AutoStop of EC2 instances"
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "cron(35 22 * * ? *)" # 10 PM daily
  schedule_expression_timezone = "Asia/Kolkata"

  target {
    arn      = aws_lambda_function.ec2_lambda.arn
    role_arn = aws_iam_role.scheduler_role.arn

    input = jsonencode({
      action = "stop"
    })
  }
}

# Lambda Permission for EventBridge Scheduler to invoke it
resource "aws_lambda_permission" "allow_start_scheduler" {
  statement_id  = "AllowExecutionFromStartScheduler"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ec2_lambda.function_name
  principal     = "scheduler.amazonaws.com"
  source_arn    = aws_scheduler_schedule.start_schedule.arn
}

resource "aws_lambda_permission" "allow_stop_scheduler" {
  statement_id  = "AllowExecutionFromStopScheduler"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ec2_lambda.function_name
  principal     = "scheduler.amazonaws.com"
  source_arn    = aws_scheduler_schedule.stop_schedule.arn
}
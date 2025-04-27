resource "aws_iam_role" "lambda_role" {
  name = "lambda-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Role_usage = "Permission for EC2 scheduler"
  }
}

resource "aws_iam_policy_attachment" "lambda_ec2_attach" {
  name       = "lambda-ec2-policy-attach"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

##the handler specifies the entry point of your Lambda function. It typically follows the format filename.function_name. 

resource "aws_lambda_function" "ec2_lambda" {
  description      = "Lambda function for EC2 Scheduler"
  architectures    = ["x86_64"]
  function_name    = var.lambda_function_name
  handler          = "ec2_lambda.lambda_handler" #filename.handler
  runtime          = "python3.12"
  role             = aws_iam_role.lambda_role.arn
  filename         = "ec2_lambda.zip"
  source_code_hash = filebase64sha256("ec2_lambda.zip")

  logging_config {
    log_format = "JSON"
  }
}

resource "aws_cloudwatch_log_group" "cloudwatch_logs" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  log_group_class   = "STANDARD"
  retention_in_days = 14
}
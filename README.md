# lambda-ec2-orchestrator
For scheduling EC2 instances Start/Stop using lambda and cloudwatch events (eventsbridge).


![image](https://github.com/user-attachments/assets/7f819bd9-39a6-450c-84d9-7879676564cd)



│ Error: creating IAM Role (lambda-ec2-role): operation error IAM: CreateRole, https response error StatusCode: 400, RequestID: 6a32e9ec-5e37-4240-86db-1f24bf531a73, MalformedPolicyDocument: Unknown field statement
│
│   with aws_iam_role.lambda_role,
│   on lambda.tf line 1, in resource "aws_iam_role" "lambda_role":
│    1: resource "aws_iam_role" "lambda_role" {
│

assume_role_policy = jsonencode({
    version = "2012-10-17"
    statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
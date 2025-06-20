# lambda-ec2-orchestrator
For scheduling EC2 instances Start/Stop using lambda and cloudwatch events (eventsbridge).

![image](https://github.com/user-attachments/assets/7f819bd9-39a6-450c-84d9-7879676564cd)

## Method 2: Amazon EventBridge with AWS Lambda 
This method offers more flexibility but requires some coding.

a. Create a Lambda function:

Open the AWS Lambda console: https://console.aws.amazon.com/lambda/ 
Create a new function and write code to stop EC2 instances

b. Set up an EventBridge schedule:
Open the Amazon EventBridge console: https://console.aws.amazon.com/events/ 
Create a new rule with a cron expression (e.g., "0 0 * * ? *" for midnight every day)
Set the Lambda function as the target for this rule

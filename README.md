# lambda-ec2-orchestrator
For scheduling EC2 instances Start/Stop using lambda and cloudwatch events (eventsbridge).

![image](https://github.com/user-attachments/assets/7f819bd9-39a6-450c-84d9-7879676564cd)

![image](https://github.com/user-attachments/assets/57a42a86-5fe4-415c-84e8-1b028a9614a2)


## Method 2: Amazon EventBridge with AWS Lambda 
This method offers more flexibility but requires some coding. I've used both manual and Terraform approach. Below step are for Manual setup

a. Create a Lambda function:

![image](https://github.com/user-attachments/assets/3f003fc8-2be1-4f10-9e58-ea38f371cd3d)

Open the AWS Lambda console: https://console.aws.amazon.com/lambda/ 
Create a new function and write code to stop EC2 instances

![image](https://github.com/user-attachments/assets/1e158f3a-b43e-4429-ac05-4bcce6946349)


b. Set up an EventBridge schedule:
Open the Amazon EventBridge console: https://console.aws.amazon.com/events/ 

![image](https://github.com/user-attachments/assets/347b00e0-ca60-4925-ad48-3bb52d89a1bc)


Create a new rule with a cron expression (e.g., "0 0 * * ? *" for midnight every day)

![image](https://github.com/user-attachments/assets/a91d5992-9f44-49d0-bd7c-b77e9425e3d9)


https://docs.aws.amazon.com/scheduler/latest/UserGuide/schedule-types.html?icmpid=docs_console_unmapped#cron-based

![image](https://github.com/user-attachments/assets/4771ee00-2995-4839-9e50-9bcff02b401e)

Set the Lambda function as the target for this rule

![image](https://github.com/user-attachments/assets/3d1e25e3-9eba-4acb-b604-0b4b4e999a96)

![image](https://github.com/user-attachments/assets/f78088eb-f7eb-4caa-a4c4-04a310728549)

IAM Role:
![image](https://github.com/user-attachments/assets/c596fc7d-26a7-450d-a325-acd64e92a0c4)

EventBridge Policy for the role:
![image](https://github.com/user-attachments/assets/90d8ba77-6093-46f9-a81b-4b7c452b640d)

Final result After execution of the Cron job
For EC2 Stop:

![image](https://github.com/user-attachments/assets/c9abb7b0-7c28-4ef1-92fe-f468f1c1a455)

For EC2 Start:

![image](https://github.com/user-attachments/assets/2e919515-4cef-400e-903f-08749188b811)

Checking cloudTrail to verify by which user/role it was executed

![image](https://github.com/user-attachments/assets/7dc07c48-3ed1-4e9b-934f-039812608208)

![image](https://github.com/user-attachments/assets/55a4c860-1b89-4d8a-bfc1-d76dacf83512)

![image](https://github.com/user-attachments/assets/d7b8b5af-1e69-4b02-a8be-d08dd718184c)

AutoScaling Launch:

![image](https://github.com/user-attachments/assets/bbfa0b74-5e33-418f-9d2e-fa24f126657a)

CloudWatch LogStream:

![image](https://github.com/user-attachments/assets/bce96834-4bcc-4e4f-b0e1-ba01b3759e12)

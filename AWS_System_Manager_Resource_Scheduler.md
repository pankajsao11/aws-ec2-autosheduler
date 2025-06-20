## AWS Systems Manager Resource Scheduler 
This method is straightforward and doesn't require coding.
![image](https://github.com/user-attachments/assets/b6eadf87-714e-4494-b4df-720a69e6f2da)

a. Open the AWS Systems Manager console: https://console.aws.amazon.com/systems-manager/  
b. In the navigation pane, choose "Quick Setup" 
![image](https://github.com/user-attachments/assets/c6f0b3a3-5b66-4b4b-a451-88ca5ca40e45)

c. On the "Resource Scheduler" card, choose "Create" 
![image](https://github.com/user-attachments/assets/8c534e80-bd94-4fa8-869a-f82293527b7c)

d. Specify the tag key and value for your EC2 instances (e.g., Key: "AutoStop", Value: "True") 
![image](https://github.com/user-attachments/assets/15dec594-ddac-44ef-aff5-b18ad8e3e224)

e. Configure the schedule to stop your instances at the desired time 
![image](https://github.com/user-attachments/assets/d14ef6fc-cde5-4759-beca-394c22ca91ab)

f. Review and create the configuration
![image](https://github.com/user-attachments/assets/c7d66b74-f333-40b0-ba0e-b346c8f91275)

![image](https://github.com/user-attachments/assets/77358c98-e05e-437c-8f5f-92b05a979068)



## Tag Your Instances
>>For either method, add the appropriate tags to the EC2 instances you want to automatically shut down.

a. Open the Amazon EC2 console: https://console.aws.amazon.com/ec2/  
b. Select the instances you want to automatically shut down c. Choose "Actions" > "Instance settings" > "Add/Edit Tags" 
d. Add the tag you specified in your chosen method (e.g., Key: "AutoStop", Value: "True")
![image](https://github.com/user-attachments/assets/1db1ef38-dba7-434d-b699-6bab79d2731b)


## Test and Monitor After setting up automatic shutdown:

a. Monitor your instances to ensure they're stopping as expected 
b. Check your AWS bills to confirm cost savings 
c. Adjust your schedule or configuration as needed
![image](https://github.com/user-attachments/assets/a52d68ed-1bdb-481f-9bc8-64c3cf4470f0)


## Consider Additional Settings For a more comprehensive solution:

a. Set up automatic start times if needed 
b. Configure CloudWatch alarms to notify you of any issues 
c. Regularly review your automatic shutdown configuration to ensure it aligns with your current needs

By following these steps, you've successfully set up automatic shutdown for your EC2 instances. This will help you manage costs by ensuring instances are only running when needed.

References: 
1. https://aws.amazon.com/blogs/publicsector/reduce-it-costs-by-implementing-automatic-shutdown-for-amazon-ec2-instances/
2. https://repost.aws/questions/QUpyZiMWC0TPG7TwD3cykDQA/can-i-schedule-an-automatic-shutdown-for-an-ec2-instance-every-night
3. https://docs.aws.amazon.com/solutions/latest/instance-scheduler-on-aws/instance-shutdown-behavior.html
4. https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/schedevents_actions_retire.html

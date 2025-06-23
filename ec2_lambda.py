import boto3
import os

def lambda_handler(event, context):
    action = event.get('action', '').lower()
    '''This Python expression commonly used to handle dictionary data structures.
    Here's what's happening:
-   event.get('action', ''): The get() method retrieves the value associated with the key 'action' from the dictionary event. If 'action' is not a key in the dictionary (or its value is None), it returns the default value specified as the second parameter—an empty string ('') in this case.'''
    
    tag_key = os.environ.get('TAG_KEY', 'AutoSchedule')
    tag_value = os.environ.get('TAG_VALUE', 'True')
    regions = os.environ.get('REGIONS', 'us-east-1').split(',')

    for region in regions:
        ec2 = boto3.client('ec2', region_name=region)

        #filter instance by tag
        filters = [{
            'Name': f'tag:{tag_key}',
            'Values': [tag_value]
        }]

        response = ec2.describe_instances(Filters=filters)
        instance_ids = []
    
        for reservation in response['Reservations']:
            for instance in reservation['Instances']:
                instance_ids.append(instance['InstanceID'])
             
        if not instance_ids:
            print(f'No Instances with Tag {tag_key} = {tag_value} found in region {region}.')
            continue
        
        #perform action
        if action == 'start':
            print(f'Starting Instances in {region}: {instance_ids}')
            ec2.start_instances(Instance_Ids=instance_ids)

        elif action == "stop":
            print(f'Stopping Instance in {region}: {instance_ids}')
            ec2.stop_instances(Instance_Ids=instance_ids)
        
        else:
            print(f'Invalid action: {action}')

'''
#code explanation:

>>import boto3 & import os
boto3 is the AWS SDK for Python, used to interact with AWS services (like EC2).
os is used to read environment variables like regions and tag filters.

>>def lambda_handler(event, context):
This is the main handler that gets triggered by AWS (e.g., via EventBridge).
event carries the input (like { "action": "start" }) and context contains metadata.

>>action = event.get('action', '').lower()
It checks if the action (either "start" or "stop") is present in the event.
If not, it defaults to an empty string.
It converts the action to lowercase to ensure case-insensitive matching.

>>Read Environment Variables
tag_key = os.environ.get('TAG_KEY', 'Schedule')=>the tag key to filter EC2 instances (e.g., "Schedule")
tag_value = os.environ.get('TAG_VALUE', 'true')=>the value for that tag key (e.g., "true")
regions = os.environ.get('REGIONS', 'us-east-1').split(',')=>comma-separated AWS regions to scan and act on
These are values defined in the Lambda console as environment variables:

>>Iterate Over Regions
for region in regions:
    ec2 = boto3.client('ec2', region_name=region)=>Creates an EC2 client for each region listed.

>>Build Filter Based on Tags
filters = [{
    'Name': f'tag:{tag_key}',
    'Values': [tag_value]
}]
Filters EC2 instances that match a specific tag (e.g., tag:Schedule = true).

>>Describe (List) Instances with the Tag
response = ec2.describe_instances(Filters=filters)
Retrieves all instances that match the tag.

>>Extract Instance IDs
instance_ids = []
for reservation in response['Reservations']:
    for instance in reservation['Instances']:
        instance_ids.append(instance['InstanceId'])
AWS groups instances in "reservations", so you loop through each reservation and each instance to collect all matching instance IDs.

>>If No Instances Found
if not instance_ids:
    print(f"No instances with tag {tag_key}={tag_value} found in region {region}.")
    continue
Skips the region if no instances match the tag.

>>Start or Stop Instances Based on Action
if action == 'start':
    ec2.start_instances(InstanceIds=instance_ids)
elif action == 'stop':
    ec2.stop_instances(InstanceIds=instance_ids)
Depending on whether the action is "start" or "stop", it calls the respective EC2 API to start or stop the matching instances.
'''
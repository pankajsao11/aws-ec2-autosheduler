import boto3

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    instance_ids = [event.get('instance_id')]
    action = event.get('action', '').lower()
    '''This Python expression commonly used to handle dictionary data structures.
    Here's what's happening:
-   event.get('action', ''): The get() method retrieves the value associated with the key 'action' from the dictionary event. If 'action' is not a key in the dictionary (or its value is None), it returns the default value specified as the second parameter—an empty string ('') in this case.'''
    
    if action == "start":
        ec2.start_instances(InstanceIds=instance_ids)
        return {
            "statusCode": 200,
            "status": "started",
            "body": f'Successfully started instance(s): {instance_ids}'
        }
    
    elif action == "stop":
        ec2.stop_instances(InstanceIds=instance_ids)
        return {
            "statusCode": 200,
            "status": "stopped",
            "body": f'Successfully stopped instance(s): {instance_ids}' 
        }
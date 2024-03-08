# Lambda function code for processing orders from SQS queue (process_order_lambda)

import json
import boto3
import os

def lambda_handler(event, context):
    # Get the SQS queue URL from environment variables
    queue_url = os.environ['QUEUE_URL']
    
    # Create SQS client
    sqs = boto3.client('sqs')
    
    # Receive messages from the SQS queue
    response = sqs.receive_message(
        QueueUrl=queue_url,
        MaxNumberOfMessages=1,
        VisibilityTimeout=10,
        WaitTimeSeconds=20
    )
    
    # Check if there are messages in the response
    if 'Messages' in response:
        # Process each message
        for message in response['Messages']:
            # Process the order (example: print the order data)
            order_data = json.loads(message['Body'])
            print("Order", order_data, "has been processed")
            
            # Delete the message from the queue
            receipt_handle = message['ReceiptHandle']
            sqs.delete_message(
                QueueUrl=queue_url,
                ReceiptHandle=receipt_handle
            )
            
        return {
            'statusCode': 200,
            'body': json.dumps('Orders processed successfully!')
        }
    else:
        return {
            'statusCode': 200,
            'body': json.dumps('No orders to process at the moment.')
        }

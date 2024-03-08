import json  # Importing the JSON module to work with JSON data
import boto3  # Importing the Boto3 library to interact with AWS services
import os

def lambda_handler(event, context):
    # The `lambda_handler` function is the entry point for the Lambda execution.

    # Parse the incoming event data which contains information about the request.
    body = json.loads(event['body'])  
    # We're extracting the 'body' key from the event dictionary and converting it from JSON to a Python dictionary.

    # Extracting 'orderId' and 'orderDetails' from the parsed body.
    order_id = body['orderId']
    order_details = body['orderDetails']
    
    # Connect to SQS (Simple Queue Service)
    sqs = boto3.client('sqs')  
    # We're creating a client for SQS using Boto3, which allows us to interact with SQS.
    
    # Get the URL of the SQS queue from environment variables.
    queue_url = os.environ['QUEUE_URL']
    # We're fetching the URL of the SQS queue from the environment variables provided by Lambda.
    
    # Send a message to the SQS queue containing the order details.
    response = sqs.send_message(
        QueueUrl=queue_url,
        MessageBody=json.dumps({'orderId': order_id, 'orderDetails': order_details})
    )
    # We're sending a message to the SQS queue with the order details as JSON data.
    
    # Return a response indicating the successful processing of the order.
    return {
        'statusCode': 200,
        'body': json.dumps({'message': 'Order received and added to the queue'})
    }
    # We're returning a response with a status code and a JSON body indicating that the order was successfully processed.


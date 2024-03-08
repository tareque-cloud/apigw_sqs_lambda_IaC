# Define the Lambda function for receiving orders
resource "aws_lambda_function" "add_order_lambda" {
  
  function_name = var.lambda_function_add_order_name
  #role             = aws_iam_role.iam_for_lambda.arn
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = var.lambda_function_add_order_runtime    # Use the desired runtime
  timeout          = var.lambda_function_add_order_timeout    # Use the desired time execution
  filename         = "add_order_lambda.zip"                   # Replace with the path to your Lambda function code zip file
  source_code_hash = filebase64sha256("add_order_lambda.zip") # Compute hash of the Lambda function code

  environment {
    variables = {
      QUEUE_URL = aws_sqs_queue.order_queue.id # Pass the SQS queue URL as an environment variable
    }
  }

  # Set environment variables for the Lambda function

}

# Define the Lambda function for processing orders
resource "aws_lambda_function" "process_order_lambda" {
  function_name = var.lambda_function_process_order_name
  #role             = aws_iam_role.iam_for_lambda.arn
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = var.lambda_function_process_order_runtime                                 # Use the desired runtime
  timeout          = var.lambda_function_process_order_timeout                                           # Use the desired time execution
  filename         = "process_order_lambda.zip"                   # Replace with the path to your Lambda function code zip file
  source_code_hash = filebase64sha256("process_order_lambda.zip") # Compute hash of the Lambda function code
  environment {
    variables = {
      QUEUE_URL = aws_sqs_queue.order_queue.id # Pass the SQS queue URL as an environment variable
    }
  }
  #Optionally, you can set additional configurations for the Lambda function here
}


resource "aws_lambda_permission" "add_order_lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.add_order_lambda.arn
  principal     = "apigateway.amazonaws.com" # Allow API Gateway to invoke the Lambda function
  source_arn    = "${aws_api_gateway_rest_api.order_api.execution_arn}/*"
  
}


# Allow Lambda functions to send messages to SQS Queue
resource "aws_lambda_permission" "allow_sqs" {
  statement_id  = "AllowExecutionFromLambda"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.add_order_lambda.function_name
  principal     = "sqs.amazonaws.com"
  source_arn    = aws_sqs_queue.order_queue.arn
}

resource "aws_lambda_permission" "process_order_lambda_permission" {
  statement_id  = "AllowExecutionFromSQS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.process_order_lambda.function_name
  principal     = "sqs.amazonaws.com" # Allow SQS to trigger the Lambda function
  source_arn    = aws_sqs_queue.order_queue.arn


  #Specify the source ARN as the SQS queue
  #source_arn = aws_sqs_queue.order_queue.arn
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  depends_on = [ aws_sqs_queue.order_queue ]
  event_source_arn = aws_sqs_queue.order_queue.arn
  function_name    = aws_lambda_function.process_order_lambda.function_name
}
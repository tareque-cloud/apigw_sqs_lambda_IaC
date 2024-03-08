# Create an SQS queue to store orders
resource "aws_sqs_queue" "order_queue" {

  name                  = var.sqs_queue_name
  sqs_managed_sse_enabled = var.sqs_queue_sse_enabled
  visibility_timeout_seconds = var.sqs_queue_visibility_timeout
  
  
  
  # Optionally, you can configure additional settings for the SQS queue here

}





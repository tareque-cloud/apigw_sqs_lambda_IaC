# Create API Gateway for the REST interface
resource "aws_api_gateway_rest_api" "order_api" {
  name = var.rest_api_gateway_name
  # Optionally, you can set additional configurations for the API Gateway here
}

# Define a resource for the API Gateway
resource "aws_api_gateway_resource" "order_api_resource" {
  rest_api_id = aws_api_gateway_rest_api.order_api.id
  parent_id   = aws_api_gateway_rest_api.order_api.root_resource_id
  path_part   = var.api_gateway_resource_path
  # Optionally, you can set additional configurations for the API Gateway resource here
}

# Define the POST method for the API Gateway resource
resource "aws_api_gateway_method" "order_api_method" {
  rest_api_id   = aws_api_gateway_rest_api.order_api.id
  resource_id   = aws_api_gateway_resource.order_api_resource.id
  http_method   = var.api_gateway_method
  authorization = var.api_gateway_authorization
  # Optionally, you can set additional configurations for the API Gateway method here
}

# Integrate the API Gateway with the "AddOrder-Lambda" Lambda function
resource "aws_api_gateway_integration" "order_api_integration" {
  rest_api_id             = aws_api_gateway_rest_api.order_api.id
  resource_id             = aws_api_gateway_resource.order_api_resource.id
  http_method             = aws_api_gateway_method.order_api_method.http_method
  integration_http_method = var.api_gateway_integration_with_lambda_method
  type                    = var.api_gateway_integration_type
  uri                     = aws_lambda_function.add_order_lambda.invoke_arn
  # Optionally, you can set additional configurations for the API Gateway integration here
}

# Deploy the API Gateway
resource "aws_api_gateway_deployment" "order_api_deployment" {
  depends_on  = [aws_api_gateway_integration.order_api_integration]
  rest_api_id = aws_api_gateway_rest_api.order_api.id
  stage_name  = var.api_gateway_deployment_stage_name
  # Optionally, you can set additional configurations for the API Gateway deployment here
}


# output "api_gateway_endpoint" {
#   value = aws_api_gateway_deployment.order_api_deployment.invoke_url
# }
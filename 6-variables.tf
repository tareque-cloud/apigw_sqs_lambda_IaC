# AWS Region variable

variable "aws_region" {
    description = "AWS Region"
    type = string
    default = "eu-central-1"
}

# AWS api Gateway variables

variable "rest_api_gateway_name" {

    description = "Name of the REST API Gateway"
    type = string
    default = "OrderAPI"
  
}

variable "api_gateway_resource_path" {

    description = "Name of the Path for API Gateway"
    type = string
    default = "order"

  
}

variable "api_gateway_method" {

    description = "Methods for API Gateway"

    type = string
    default = "POST"
  
}

variable "api_gateway_authorization" {

    description = "API Gateway Authorization"
    type = string
    default = "NONE"
  
}

variable "api_gateway_integration_with_lambda_method" {

    description = "lambda Method"
    type = string
    default = "POST"
  
}

variable "api_gateway_integration_type" {

    description = "Integration Type of API Gateway"
    type = string
    default = "AWS_PROXY"
  
}

variable "api_gateway_deployment_stage_name" {

    description = "API Gateway Stage Name"
    type = string
    default = "prod"
  
}

# lambda function add_order variables


variable "lambda_function_add_order_name" {



    description = "Add Order lambda function name"
    type = string
    default = "AddOrder-Lambda"
  
}

variable "lambda_function_add_order_runtime" {

    description = "Add Order lambda function runtime"
    type = string
    default = "python3.12"
  
}

variable "lambda_function_add_order_timeout" {

    description = "Add Order lambda function execution timeout"
    type = number
    default = 10
  
}


# lambda function process_order variables


variable "lambda_function_process_order_name" {

    description = "Process Order lambda function name"
    type = string
    default = "ProcessOrder-Lambda"
  
}

variable "lambda_function_process_order_runtime" {

    description = "Process Order lambda function runtime"
    type = string
    default = "python3.12"
  
}

variable "lambda_function_process_order_timeout" {

    description = "Process Order lambda function execution timeout"
    type = number
    default = 10
  
}

# AWS SQS Variables

variable "sqs_queue_name" {

    description = "AWS SQS Name "
    type = string
    default = "OrderQueue"
  
}

variable "sqs_queue_sse_enabled" {

    description = "AWS SQS SSE enabled status value"
    type = bool
    default = false
  
}

variable "sqs_queue_visibility_timeout" {


    description = "AWS SQS Visibility Timeout Value"
    type = number
    default = 10
  
}
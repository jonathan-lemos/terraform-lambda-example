resource "aws_api_gateway_rest_api" "hello_world_lambda_gateway" {
  name = "HelloWorldLambdaGateway"
  description = "Hello world lambda gateway"
}

resource "aws_api_gateway_resource" "hello_world_proxy" {
  rest_api_id = aws_api_gateway_rest_api.hello_world_lambda_gateway.id
  parent_id = aws_api_gateway_rest_api.hello_world_lambda_gateway.root_resource_id
  path_part = "{proxy+}"
}

resource "aws_api_gateway_method" "hello_world_proxy" {
  authorization = "NONE"
  http_method = "ANY"
  resource_id = aws_api_gateway_resource.hello_world_proxy.id
  rest_api_id = aws_api_gateway_rest_api.hello_world_lambda_gateway.id
}

resource "aws_api_gateway_integration" "hello_world_proxy" {
  rest_api_id = aws_api_gateway_rest_api.hello_world_lambda_gateway.id
  resource_id = aws_api_gateway_method.hello_world_proxy.resource_id
  http_method = aws_api_gateway_method.hello_world_proxy.http_method

  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = aws_lambda_function.hello_world_lambda.invoke_arn
}

resource "aws_api_gateway_method" "hello_world_proxy_root" {
  authorization = "NONE"
  http_method = "ANY"
  resource_id = aws_api_gateway_rest_api.hello_world_lambda_gateway.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.hello_world_lambda_gateway.id
}

resource "aws_api_gateway_integration" "hello_world_proxy_root" {
  rest_api_id = aws_api_gateway_rest_api.hello_world_lambda_gateway.id
  resource_id = aws_api_gateway_method.hello_world_proxy_root.resource_id
  http_method = aws_api_gateway_method.hello_world_proxy_root.http_method

  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = aws_lambda_function.hello_world_lambda.invoke_arn
}

resource "aws_api_gateway_deployment" "hello_world" {
  depends_on = [
    aws_api_gateway_integration.hello_world_proxy,
    aws_api_gateway_integration.hello_world_proxy_root
  ]
  
  rest_api_id = aws_api_gateway_rest_api.hello_world_lambda_gateway.id
  stage_name = "hello_world_test"
}

output "base_url" {
  value = aws_api_gateway_deployment.hello_world.invoke_url
}
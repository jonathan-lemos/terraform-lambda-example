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


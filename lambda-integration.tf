resource "aws_lambda_permission" "hello_world_permission" {
  statement_id = "AllowAPIGatewayInvoke"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.hello_world_lambda.function_name
  principal = "apigateway.amazonaws.com"
  
  source_arn = "${aws_api_gateway_rest_api.hello_world_lambda_gateway.execution_arn}/*/*"
}
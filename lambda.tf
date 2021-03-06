resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
        Sid = ""
      }
    ]
  })
}

resource "aws_lambda_function" "hello_world_lambda" {
  filename = "hello_world_lambda_payload.zip"
  function_name = "hello_world_lambda"
  role = aws_iam_role.iam_for_lambda.arn
  handler = "HelloWorld::HelloWorld.Function::FunctionHandler"
  
  source_code_hash = filebase64sha256("hello_world_lambda_payload.zip")
  
  runtime = "dotnetcore3.1"
}
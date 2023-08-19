provider "aws" {
  region = "eu-central-1"
}

resource "aws_lambda_function" "ec2_script_lambda_no_iam" {
  function_name    = "ec2_script_lambda_no_iam"
  filename         = "lambda_function_payload.zip"
  handler          = "main.get_ec2_instances" # Now using 'main' to refer to the 'main.py' file.
  runtime          = "python3.8"
  role             = "arn:aws:iam::115189082206:role/platform-test-mbergo-role"
  source_code_hash = filebase64sha256("lambda_function_payload.zip")
}

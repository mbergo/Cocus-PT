provider "aws" {
  region = "eu-central-1"
  assume_role {
    role_arn = aws_iam_role.terraform_role.arn
  }
}

resource "aws_lambda_function" "ec2_script_lambda" {
  function_name    = "ec2_script_lambda"
  s3_bucket        = var.lambda_s3_bucket
  s3_key           = var.lambda_s3_key
  handler          = "ec2_script.get_ec2_instances"
  runtime          = "python3.8"
  role             = aws_iam_role.lambda_exec_role.arn
  source_code_hash = filebase64sha256(var.lambda_s3_key)
}

resource "aws_iam_role" "terraform_role" {
  name = "platform-test-mbergo-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_policy" "terraform_policy" {
  name        = "platform-test-mbergo-policy"
  description = "Policy that allows Terraform to deploy resources"
  
  policy = # Here we will need to define the actual permissions your resources will need.
}

resource "aws_iam_role_policy_attachment" "terraform_attach" {
  policy_arn = aws_iam_policy.terraform_policy.arn
  role       = aws_iam_role.terraform_role.name
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role_for_ec2_script"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_exec_role_attach" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_exec_role.name
}

output "lambda_arn_no_iam" {
  description = "The ARN of the Lambda function."
  value       = aws_lambda_function.ec2_script_lambda_no_iam.arn
}

variable "region" {
  description = "The AWS region"
  default     = "eu-central-1"
}

variable "lambda_s3_bucket" {
  description = "The S3 bucket where the Lambda function code is stored"
  default     = "my-lambda-deployment-bucket"
}

variable "lambda_s3_key" {
  description = "The S3 key for the Lambda function code"
  default     = "lambda_function_payload.zip"
}

# EC2 Inspector Lambda

A Python-based AWS Lambda function to inspect EC2 instances using Boto3.

## Project Structure:

```
├── lambda_function
│   ├── main.py
│   └── requirements.txt
├── Makefile
├── README.md
└── terraform
    ├── main.tf
    ├── backend.tf
    ├── lambda.zip
    └── variables.tf
```

## Setup and Deployment:

### AWS Credentials:

Before you begin, make sure you've set your AWS credentials as environment variables. You can do this by executing the following:

```bash
export AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=YOUR_SECRET_KEY
```

Replace `YOUR_ACCESS_KEY` and `YOUR_SECRET_KEY` with your actual credentials. This ensures your credentials are not hardcoded anywhere in the project.

1. **Install Required Python Packages**:

```bash
make install
```

2. **Run the Script Locally**:

```bash
make run
```

3. **Package the Lambda Function**:

```bash
make package
```

4. **Install the Specified Terraform Version**:

```bash
make install_terraform
```

5. **Initialize the Terraform Workspace**:

```bash
make init
```

6. **Apply the Terraform Configuration**:

This will deploy the Lambda function:

```bash
make apply
```

7. **Destroy the Created Resources**:

```bash
make destroy
```

## State Management with S3:

This setup uses AWS S3 to store the Terraform state file. Ensure you've set up an S3 bucket and specified its name in `backend.tf`.

Remember to never commit sensitive information like AWS credentials. Always use environment variables or other secure methods.

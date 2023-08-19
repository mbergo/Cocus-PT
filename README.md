# EC2 Instances Fetcher

Hello! I'm Marcus Bergo applying for Cocus PT. I embarked on a challenge to create an AWS Lambda function that fetches EC2 instance details and presents them in a tabular format.

## Project Structure

```
├── main.py
├── Makefile
├── output_example.txt
├── problems-and-solutions.md
├── README.md
├── requirements.txt
├── scripts
│   └── create-attach-policy.sh
├── terraform
│   ├── backend.tf
│   ├── main.tf
│   ├── output.tf
│   ├── policy.json
│   ├── terraform-no-iam
│   │   ├── lambda_function_payload.zip
│   │   ├── main-no-iam.tf
│   │   ├── outputs-no-iam.tf
│   │   └── variables-no-iam.tf
│   ├── trust_policy.json
│   └── variables.tf
└── tests
    └── test_main.py
```

## Introduction

This project is designed to list EC2 instances with some key details. The main logic is encapsulated in `main.py`. However, I wanted to leverage AWS Lambda to make this available as a serverless function. Unfortunately, I encountered several permissions challenges during deployment which are detailed below.

## Permissions Challenges & Considerations

During the deployment phase, I faced significant IAM permission constraints, which prevented me from deploying the Lambda function via Terraform. The user `svc.115189082206.tda.cocustest` lacked the necessary permissions to perform specific IAM-related operations like creating a policy and attaching it.

If you're using this codebase in an AWS environment with strict IAM policies or permissions boundaries, be cautious.

Specifically, I ran into issues with the `iam:CreatePolicy` permission when trying to create a new IAM policy. If you encounter a similar issue, you'll either need elevated permissions or the assistance of an AWS administrator.

## Why `terraform-no-iam`?

You might notice there's a folder named `terraform-no-iam`. Due to the permissions constraints, I decided to separate the Terraform configuration that doesn't require any IAM-related actions. This is to ensure that other parts of the infrastructure can still be provisioned even if the IAM part fails due to permissions issues. Even though, I got in trouble with permissions again. Please see [problems-and-solutions](problems-and-solutions.md)

## How to Use

1. **Local Execution**: Navigate to the project's root directory and run:

    ```bash
    python main.py [SEARCH_KEYWORD]
    ```

2. **Lambda Deployment**: This might be challenging without the correct permissions. But in a suitable environment, navigate to the `terraform-no-iam` directory and execute:

    ```bash
    terraform init
    terraform apply
    ```

3. **Unit Tests**: Navigate to the `tests` directory and run:

    ```bash
    python -m unittest test_main.py
    ```

## Closing Thoughts

This project was pretty cool, especially understanding the nuances of AWS IAM. If you're planning to use or adapt this codebase, always remember to verify your IAM permissions and ensure you're adhering to the principle of least privilege.


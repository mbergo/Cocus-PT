
# EC2 Instances Explorer - Cocus PT

Hello! I'm *Marcus Bergo* applying for Cocus PT, and I've embarked on this  challenge of creating a project that can fetch and list EC2 instances based on a search criterion via an AWS Lambda function.

## Repository Structure

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
│   │   ├── main.py
│   │   ├── outputs-no-iam.tf
│   │   └── variables-no-iam.tf
│   ├── trust_policy.json
│   └── variables.tf
└── tests
    └── test_main.py
```

## The Journey of "terraform-no-iam"

In the course of this challenge, I hit some roadblocks, primarily due to permission restrictions when attempting to orchestrate certain AWS IAM roles and policies through Terraform. To circumvent these permission errors, I forged the "terraform-no-iam" directory. It's essentially a variant of the Terraform configurations that avoids direct IAM operations but still achieves the desired functionality.

## Setting Things Up

1. **Dependencies First!**
   To start, you'd want to install the required Python libraries. Here's how I do it:

   ```
   make setup
   ```

2. **Let's Package the Lambda Payload**
   This will neatly zip the `main.py` from our root directory and tuck the zipped payload into the `terraform-no-iam` directory. This is primed for Terraform to take over.

   ```
   make create-zip
   ```

3. **Unleashing Terraform**
   Time to apply the Terraform configurations. Here's how I go about it:

   ```
   make apply-terraform
   ```

4. **Quality Assurance with Tests**
   It's always good to double-check. I run the unit tests to ensure everything's ticking as expected and as good manners :):

   ```
   make test
   ```

5. **Clean-Up Time**
   If there's ever a need to dismantle the AWS resources created by Terraform, here's what I use:

   ```
   make destroy-terraform
   ```

## Collaboration

Always open to fresh ideas and perspectives! Feel free to raise pull requests. Just a small ask: please ensure to update or add tests as appropriate.

## Licensing

Under the [MIT](https://spdx.org/licenses/MIT.html) license.

#!/bin/bash

# Define the policy and role names
POLICY_NAME="platform-team-mbergo-policy"
ROLE_NAME="platform-team-mbergo-role"

# Create the IAM Policy
POLICY=$(cat << EOM
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Resource": "arn:aws:iam::115189082206:role/platform-test*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:CreatePolicy",
            "Resource": "arn:aws:iam::115189082206:policy/platform-test*"
        }
    ]
}
EOM
)

echo "$POLICY" > temp_policy.json

aws iam create-policy --policy-name $POLICY_NAME --policy-document temp_policy.json

# Create the IAM Role
TRUST_POLICY=$(cat << EOM
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOM
)

echo "$TRUST_POLICY" > temp_trust_policy.json

aws iam create-role --role-name $ROLE_NAME --assume-role-policy-document file://temp_trust_policy.json

# Attach the IAM Policy to the IAM Role
POLICY_ARN="arn:aws:iam::115189082206:policy/$POLICY_NAME"
aws iam attach-role-policy --role-name $ROLE_NAME --policy-arn $POLICY_ARN

# Clean up temporary files
rm temp_policy.json temp_trust_policy.json

echo "Done!"

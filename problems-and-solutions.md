# 1- I tried to create a policy to store terraform state file on S3 first and then just to create the policy and attach it. Then I got

```
An error occurred (AccessDenied) when calling the CreatePolicy operation: User: arn:aws:iam::115189082206:user/svc.115189082206.tda.cocustest is not authorized to perform: iam:CreatePolicy on resource: policy platform-team-mbergo-policy because no permissions boundary allows the iam:CreatePolicy action

An error occurred (AccessDenied) when calling the CreateRole operation: User: arn:aws:iam::115189082206:user/svc.115189082206.tda.cocustest is not authorized to perform: iam:CreateRole on resource: arn:aws:iam::115189082206:role/platform-team-mbergo-role because no permissions boundary allows the iam:CreateRole action

An error occurred (AccessDenied) when calling the AttachRolePolicy operation: User: arn:aws:iam::115189082206:user/svc.115189082206.tda.cocustest is not authorized to perform: iam:AttachRolePolicy on resource: role platform-team-mbergo-role because no permissions boundary allows the iam:AttachRolePolicy action

```

### From my understanding one of those things might be happening:

- Permissions Boundary: The message "Check with AWS Account Administrator: If you're not the primary administrator of this AWS account, you should reach out to them. Explain that you need permissions to create roles and policies and that there seems to be a permissions boundary in place which is restricting your access.

- Direct IAM Policies: The user might not have the necessary policies attached to allow the creation of policies and roles.

### Therefore I would try the follow solutions:

- Review IAM User's Permissions: Navigate to the IAM dashboard in the AWS Console.
- Find the user svc.115189082206.tda.cocustest.
- Check the attached policies and permissions boundaries.
- If there's a permissions boundary set, it may be restricting the operations I can perform.
- Modify Permissions: To resolve the issue, I would either need to:
- Adjust the permissions boundary to allow the iam:CreatePolicy, iam:CreateRole, and iam:AttachRolePolicy actions.
- Attach a policy to the user that grants these permissions. However, the permissions boundary (if set) can still override and deny these. "...no permissions boundary allows the..." suggests that there's a permissions boundary set on the user, which restricts what policies the user can set on other entities.

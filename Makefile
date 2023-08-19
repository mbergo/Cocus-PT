# This Makefile streamlines various tasks for the project.

setup:
	pip3 install -r requirements.txt

test:
	python3 -m unittest tests/test_main.py

create-zip:
	zip terraform/terraform-no-iam/lambda_function_payload.zip main.py

apply-terraform:
	cd terraform && terraform init && terraform apply

destroy-terraform:
	cd terraform && terraform destroy

.PHONY: setup test create-zip apply-terraform destroy-terraform

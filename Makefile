TERRAFORM_VERSION=1.0.3

install:
	pip install -r lambda_function/requirements.txt

test:
    python -m unittest test_main.py

run:
	python lambda_function/main.py

package:
	cd lambda_function && zip -r ../terraform/lambda.zip .

init:
	cd terraform && terraform init

plan:
	cd terraform && terraform plan

apply:
	cd terraform && terraform apply -auto-approve

destroy:
	cd terraform && terraform destroy -auto-approve

install_terraform:
	curl -LO "https://releases.hashicorp.com/terraform/$(TERRAFORM_VERSION)/terraform_$(TERRAFORM_VERSION)_linux_amd64.zip"
	unzip terraform_$(TERRAFORM_VERSION)_linux_amd64.zip
	mv terraform /usr/local/bin/
	rm terraform_$(TERRAFORM_VERSION)_linux_amd64.zip

.PHONY: install run package init plan apply destroy install_terraform

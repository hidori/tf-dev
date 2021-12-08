workspace/list:
	terraform workspace list

init:
	terraform init

tfvars:
	if [ ! -e ./terraform.tfvars ]; then \
		cp ./terraform.tfvars.example ./terraform.tfvars; \
		echo "Fill up empty values of terraform.tfvars"; \
		false; \
	fi

validate: tfvars
	terraform validate

plan: tfvars
	terraform plan

apply: tfvars
	terraform apply

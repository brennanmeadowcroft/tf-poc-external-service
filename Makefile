upload:
	source ./bin/package-upload.sh

bootstrap:
	mkdir -p build
	terraform init terraform

deploy:
	terraform plan terraform
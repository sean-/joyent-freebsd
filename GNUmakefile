SSH_USER ?= root
TFSTATE_FILE ?= .terraform.state
TFVARS_FILE ?= .terraform.vars
TF_PLAN ?= .terraform.plan
ENVCHAIN_NAMESPACE ?= triton

TERRAFORM=$(shell which 2>&1 /dev/null terraform | head -1)

IMAGE_NAME ?= my-freebsd-image
IMAGE_VERSION ?= 1.0.0
TEMPLATE ?= freebsd.json

.SUFFIXES: .json .json5

# NOTES:
#
# cfgt: Required to convert from JSON5 to JSON (unless you've patched your
#       packer(1) install to accept JSON5:
#       https://github.com/sean-/packer/tree/f-json5)
#
# envchain: https://github.com/sorah/envchain
#
# env: SDC_URL, SDC_ACCOUNT, SDC_KEY_ID must be set (via envchain).  Run `triton
#      env` to get these values.  https://www.npmjs.com/package/triton

default: help

# Terraform Targets

apply: ## Applies a given Terraform plan
	$(TERRAFORM) apply -state-out=${TFSTATE_FILE} ${TF_PLAN}

plan: ## Plan a Terraform run
	$(TERRAFORM) plan -state=${TFSTATE_FILE} -var-file=${TFVARS_FILE} -out=${TF_PLAN}

plan-target: ## Plan a Terraform run against a specific target
	$(TERRAFORM) plan -state=${TFSTATE_FILE} -var-file=${TFVARS_FILE} -out=${TF_PLAN} -target=${TARGET}

fmt: ## Format Terraform files inline
	$(TERRAFORM) fmt

show: ## Show the Terraform state
	$(TERRAFORM) show ${TFSTATE_FILE}

taint: ## Taints a given resource
	$(TERRAFORM) taint -state=${TFSTATE_FILE} $(TARGET)

# Packer Targets

%.json: %.json5
	cfgt -i $< -o $@

build:: $(TEMPLATE) ## Build a FreeBSD image
	envchain $(ENVCHAIN_NAMESPACE) \
		packer build \
			-var "image_name=$(IMAGE_NAME)" \
			-var "image_version=$(IMAGE_VERSION)" \
			$(EXTRA_ARGS) \
			$(TEMPLATE)

# Triton Targets

images-freebsd:: ## Show all FreeBSD images on Triton
	envchain $(ENVCHAIN_NAMESPACE) triton images -l name=~freebsd

instances:: ## Show all running instances on Triton
	envchain $(ENVCHAIN_NAMESPACE) triton instances

my-images:: ## Show my Triton images
	envchain $(ENVCHAIN_NAMESPACE) triton images -l public=false

networks::  ## Show Triton networks
	envchain $(ENVCHAIN_NAMESPACE) triton network list -l

packages::  ## Show Triton Packages
	envchain $(ENVCHAIN_NAMESPACE) triton packages

ssh::  ## SSH to a given target on Triton
	@if [ -z "$(TARGET)" ]; then \
		printf "ERROR: specify an instance name. HINT: %s ssh TARGET=<NAME>\n" "`basename $(MAKE)`"; \
		$(MAKE) -s instances; \
		exit 1; \
	fi
	envchain $(ENVCHAIN_NAMESPACE) triton ssh $(SSH_USER)@$(TARGET)

# Misc Targets
cfgt:: ## Install cfgt(1)
	go get -u github.com/sean-/cfgt

env:: ## Show local environment variables
	@envchain $(ENVCHAIN_NAMESPACE) env | egrep -i '(SDC|Triton|Manta)'

json-config:: ## Show the config as a JSON file
	@cfgt -i freebsd.json5

.PHONY: help
help:
	@echo "Valid targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

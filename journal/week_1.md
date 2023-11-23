# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
├── variables.tf          # Variable declarations
├── main.tf               # Main Terraform configuration
├── providers.tf          # Provider configurations
├── outputs.tf            # Stores our outputs
├── terraform.tfvars      # Variable data to be loaded into the Terraform project
└── README.md             # Required for root modules
```

 
[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

Terraform has two types of variables:
- Environment Variables - these can be set in bash terminal e.g AWS credentials
- Terraform Variables - these are set in the tfvars file

Terraform Cloud variables can be set as sensitive to avoid visibility of credentials in UI.

### Loading Terraform Input Variables

Visit this link [Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables) to learn more about environment variables in terraform.

#### var flag

Append the `-var` flag to set an input variable or override a variable in the tfvars file e.g `terraform -var user_id="my-user-id"`

#### var-file flag

To set lots of variables, it is more convenient to specify their values in a variable definitions file (with a filename ending in either .tfvars or .tfvars.json) and then specify that file on the command line with -var-file e.g `terraform apply -var-file="testing.tfvars"`

## Dealing With Configuration Drift

In the case of lost statefile, tear down all your cloud infrastructure manually.

`Terraform port` is an option but doesn't apply for all cloud resources, instead check the terraform providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)

### Fix Manual Configurarion 

If a resource is deleted or modified manually, try running `Terraform plan` to put the infrastructure back into the expected state fixing the configuration drift.

### Fix using Terraform Refresh
```sh
terraform apply -refresh-only -auto-approve
```

## Terraform Modules

### Terraform Module Structure

It is recommended to place modules in a `modules` directory during local developments.

### Pasing Input Variables

Pass input variables to your module.
The module has to declare the terraform variable in its own variables.tf.
```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Module Sources

Use the source to import modules from various places e.g
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```

[Module Sources](https://developer.hashicorp.com/terraform/language/modules/sources)
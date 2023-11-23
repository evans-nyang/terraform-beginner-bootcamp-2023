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


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

## Considerations when using chatGPT to write Terraform 

LLMs e.g chatGPT may not be cognisant of latest Terraform documentation. It may likely generate depracated configuration examples affecting providers.

## Working with files in Terraform 

### Fileexists function

`fileexists` is a built-in terraform function to check existence of a file.

Check out the example usage in a variable block below: 

```
variable "index_html_filepath" {
  description = "File path for index.html"
  type        = string

  validation {
    condition     = fileexists(var.index_html_filepath)
    error_message = "Invalid path for index.html!"
  }
}
```

[Learn about fileexists](https://developer.hashicorp.com/terraform/language/functions/fileexists)

### Filemd5

`filemd5` is a built-in function, variant of `md5`, that hashes the contents of a given file rather than a literal string

[Learn about filemd5](https://developer.hashicorp.com/terraform/language/functions/filemd5)

### Path Variable
There is a special variable `path` in Terraform that allows referencing local paths as shown in the examples below:
- path.module = filesystem path of the module where the expression is placed.
- path.root = filesystem path of the root module of the configuration.
- path.cwd = filesystem path of the original working directory before any `-chdir` argument

[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

```tf
resource "aws_s3_object" "website_index" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
  etag   = filemd5("${path.root}/public/index.html")
}
```

### Working with JSON using jsonencode

`jsonencode` encodes a given value to a string using JSON syntax.

Example : 

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

## Terraform Locals

A local value assigns a name to an expression, so you can use the name multiple times within a module instead of repeating the expression.

Example usage: 

```tf
locals {
  s3_origin_id = "myS3Origin"
}
```

[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

## Terraform Data Sources

Data sources allow Terraform to use information defined outside of Terraform, defined by another separate Terraform configuration, or modified by functions.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

### Resource Lifecycle

`lifecycle` is a nested block that can appear within a resource block. The `lifecycle` block and its contents are meta-arguments, available for all resource blocks regardless of type.

[Meta Arguments Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

[Learn more about Terraform Data ](https://developer.hashicorp.com/terraform/language/resources/terraform-data)
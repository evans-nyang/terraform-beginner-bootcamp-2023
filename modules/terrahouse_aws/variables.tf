variable "region" {
  description = "Name of the aws region"
  default     = "eu-west-1"
}

variable "user_uuid" {
  type        = string
  description = "The UUID of the user."

  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$", var.user_uuid))
    error_message = "Invalid UUID format. Please provide a valid UUID."
  }
}

variable "bucket_name" {
  description = "The name of the s3 bucket"
  type        = string

  validation {
    condition = (
      length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63 &&
      can(regex("^[a-z0-9][a-z0-9-.]*[a-z0-9]$", var.bucket_name))
    )
    error_message = "The bucket name must be between 3 and 63 characters!"
  }
}

variable "index_html_filepath" {
  description = "File path for index.html"
  type        = string

  validation {
    condition     = fileexists(var.index_html_filepath)
    error_message = "Invalid path for index.html!"
  }
}

variable "error_html_filepath" {
  description = "File path for error.html"
  type        = string

  validation {
    condition     = fileexists(var.error_html_filepath)
    error_message = "Invalid path for error.html!"
  }
}

variable "content_version" {
  description = "The content version. Should be a positive integer starting at 1"
  type        = number

  validation {
    condition = var.content_version > 0 && floor(var.content_version) == var.content_version
    error_message = "The content version must be a positive integer starting at 1."
  }
}
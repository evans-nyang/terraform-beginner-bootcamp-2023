variable "user_uuid" {
  type        = string
}

variable "bucket_name" {
  type        = string
}

variable "index_html_filepath" {
  description = "File path for index.html"
  type        = string
}

variable "error_html_filepath" {
  description = "File path for error.html"
  type        = string
}

variable "content_version" {
  description = "The content version. Should be a positive integer starting at 1"
  type        = number
}

variable "assets_path" {
  description = "Path to assets directory"
  type = string
}
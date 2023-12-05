output "bucket_name" {
  description = "Bucket name for static website"
  value = aws_s3_bucket.website_bucket.bucket
}

output "website_endpoint" {
  description = "Bucket name for static website hosting endpoint"
  value = aws_s3_bucket_website_configuration.website_configuration.website_endpoint
}
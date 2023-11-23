# resource "random_string" "bucket_name" {
#   length = 32
#   lower  = true
#   upper  = false
#   numeric = true
#   special = false

#   # Use the keepers argument to associate the user_uuid variable with the random_string resource.
#   keepers = {
#     user_uuid = var.user_uuid
#   }
# }

resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name

  tags = {
    UserUuid = var.user_uuid
  }
}




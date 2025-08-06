provider "aws" {
  region = var.aws_region

}


resource "aws_s3_bucket" "chucthien_backend" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = var.s3_bucket_name
    Environment = var.environment
    Project     = var.project_name
  }

}

resource "aws_s3_bucket_versioning" "chucthien_backend_versioning" {
  bucket = aws_s3_bucket.chucthien_backend.id
  versioning_configuration {
    status = "Enabled"
  }

}


resource "aws_s3_bucket_object_lock_configuration" "example" {
  bucket = aws_s3_bucket.chucthien_backend.id

  rule {
    default_retention {
      mode = "COMPLIANCE"
      days = 5
    }
  }
}








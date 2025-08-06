

provider "aws" {
  region = "us-east-2"

}

module "s3" {
  source         = "../modules/s3"
  s3_bucket_name = "tct-backend"

}
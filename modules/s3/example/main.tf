provider "aws" {
  profile = "yodo-io"
  region  = "eu-central-1"
}

module "bucket" {
  source      = "../"
  prefix      = "some-bucket"
  environment = "test"
}

output "bucket_info" {
  value = module.bucket
}

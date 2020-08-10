provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "b" {
  bucket = "kaitlyn-bucket"
  acl    = "private"

  tags = {
    Name        = "Blog Bucket"
    Environment = "Dev"
  }
  website {
    index_document = "index.html"
    error_document = "error.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }
}
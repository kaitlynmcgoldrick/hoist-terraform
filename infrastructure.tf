provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
}

# Create S3 bucket to host static site
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

# Create 2 EC2 instances
resource "aws_instance" "web" {
  count         = 2
  ami           = "ami-0ac80df6eff0e70b5"
  instance_type = "t3.micro"
  key_name      = "hoist"

  tags = {
    Name = "hoist-internal-development"
  }
}
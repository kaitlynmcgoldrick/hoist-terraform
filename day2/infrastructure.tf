provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
}

module "blog" {
  source = "./blog"
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
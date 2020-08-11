provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
}

module "blog" {
  source = "./blog"
}

resource "aws_instance" "web" {
  count         = var.server_num
  ami           = var.machine_image
  instance_type = "t3.micro"
  key_name      = "hoist"

  tags = {
    Name = "hoist-variable-development"
  }
}

output test {
  value       = "this is a test"
}

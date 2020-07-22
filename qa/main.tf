data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "terraform-state-bucket-uk"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}


provider "aws" {
  profile    = "default"
  region     = var.region


}


resource "aws_eip1" "ip" {
    vpc = true
}

output "ip" {
  value = aws_eip1.ip.public_ip
}

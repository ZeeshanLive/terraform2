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

resource "aws_instance" "example" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"

}


resource "aws_eip" "ip" {
    vpc = true
    instance = aws_instance.example.id
}

resource "aws_eip" "ip1" {
    vpc = true
}
output "ip" {
  value = aws_eip.ip.public_ip
}
output "id" {
    value= aws_instance.example.id

}

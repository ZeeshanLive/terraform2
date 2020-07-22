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
    provisioner "local-exec" {
    command = "apt update -y && apt install ngnix -y & service nginx restart"
  }

}


resource "aws_eip" "ip" {
    vpc = true
    instance = aws_instance.example.id
}

output "ip" {
  value = aws_eip.ip.public_ip
}
output "id" {
    value= aws_instance.example.id

}
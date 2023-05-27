data "aws_availability_zones" "available"{
  state = "available"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  #owners      = ["amazon"]
  filter {
      name   = "name"
      #values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
      values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
    }
  filter {
      name   = "virtualization-type"
      values = ["hvm"]
    }
}

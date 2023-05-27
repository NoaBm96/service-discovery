variable "region" {
  type = string
  default = "us-east-1"
}

variable "key_name" {
  type = string
  default = "kandula"
  description = "The key name of the Key Pair to use for the instance"
}  

variable "private_key_path" {
  type = string
  default = "~/.ssh/kandula"
} 

variable "environment_tag"{
    type = string
    default = "kandula-mid"
}

variable "instance_type" {
  description = "The type of the ec2, for example - t2.medium"
  default     = "t2.micro"
  type        = string
}

variable "consul_server" {
  description = "The amount of consul servers"
  default     = 3
}

variable "consul_server_web" {
  description = "The amount of consul nodes"
  default     = 1
}

variable "consul_ami" {
  description = "ami (ubuntu 18) to use - based on region"
  default = {
    "us-east-1" = "ami-00ddb0e5626798373"
    "us-east-2" = "ami-0dd9f0e7df0f0a138"
  }
}


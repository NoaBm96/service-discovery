variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["10.0.100.0/24", "10.0.110.0/24"]
}

variable "vpc_cidr" {
  type = string
  description = "The cidr block of the VPC"
  default = "10.0.0.0/16"
}

variable "route_tables_name_list" {
  type    = list(string)
  description = "List of the names of the route-tables (Module creates two RTBS, one public [0] and one private [1]"
  default = ["public", "private-a", "private-b"]
}

variable "environment_tag"{
    type = string
    default = "kandula-mid"
}

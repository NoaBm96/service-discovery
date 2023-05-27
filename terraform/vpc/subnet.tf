### 2 Public Subnet ###
resource "aws_subnet" "public_subnets" {
 map_public_ip_on_launch = "true" #auto assign IP
 count      = length(var.public_subnet_cidrs) #create subnet as the amount of cidrs
 vpc_id     = aws_vpc.main.id
 cidr_block = var.public_subnet_cidrs[count.index]
 availability_zone = data.aws_availability_zones.available.names[count.index] #create each subnet in az from the all available az's list
 tags = {
   Name = "Public_subnet_${regex(".$", data.aws_availability_zones.available.names[count.index])}_${var.environment_tag}"
 }
}
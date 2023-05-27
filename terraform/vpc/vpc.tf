### VPC ###
resource "aws_vpc" "main" {
 cidr_block = var.vpc_cidr
 tags = {
   Name = "${var.environment_tag} - VPC"
 }
}

### Internet gateway ###
resource "aws_internet_gateway" "igw" {
 vpc_id = aws_vpc.main.id
 tags = {
   Name = "IGW_${var.environment_tag}"
 }
}

### elastic IP ###
resource "aws_eip" "nat_eip" {
  count = length(var.public_subnet_cidrs)
  vpc      = true
  tags = {
   Name = "NAT_EIP_${regex(".$", data.aws_availability_zones.available.names[count.index])}_${var.environment_tag}"
 }
}

### NAT gateway ###
resource "aws_nat_gateway" "nat" {
  count         = length(var.public_subnet_cidrs)
  allocation_id = aws_eip.nat_eip.*.id[count.index]
  subnet_id     = aws_subnet.public_subnets.*.id[count.index]
  tags = {
    Name = "NAT_${regex(".$", data.aws_availability_zones.available.names[count.index])}_${var.environment_tag}"
  }
}

### route table ###
resource "aws_route_table" "route_tables" {
  count = length(var.route_tables_name_list)
  vpc_id    = aws_vpc.main.id
  tags = {
   Name = "${var.route_tables_name_list[count.index]}_RTB_${var.environment_tag}"
 }
}

### public route table association ###
resource "aws_route_table_association" "public" {
 count          = length(var.public_subnet_cidrs)
 subnet_id      = aws_subnet.public_subnets.*.id[count.index]
 route_table_id = aws_route_table.route_tables[0].id
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.route_tables[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
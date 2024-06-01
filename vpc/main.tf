###  RESOURCES  ########################################################

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  count                   = var.public_subnet_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-public-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count             = var.private_subnet_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = {
    Name = "${var.vpc_name}-private-${count.index}"
  }
}


### NETWORKING  ########################################################


resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-public"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  count          = var.public_subnet_count
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.main.id
#   tags = {
#     Name = "${var.vpc_name}-private"
#   }
# }

# resource "aws_nat_gateway" "main" {
#   count         = var.private_subnet_count
#   allocation_id = aws_eip.nat[count.index].id
#   subnet_id     = element(aws_subnet.public.*.id, count.index)
#   tags = {
#     Name = "${var.vpc_name}-nat-${count.index}"
#   }
# }

# resource "aws_eip" "nat" {
#   count      = var.private_subnet_count
#   vpc        = true
#   depends_on = [aws_internet_gateway.main]
#   tags = {
#     Name = "${var.vpc_name}-eip-${count.index}"
#   }
# }

# resource "aws_route" "private_internet_access" {
#   count                  = var.private_subnet_count
#   route_table_id         = aws_route_table.private.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.main[count.index].id
# }

# resource "aws_route_table_association" "private" {
#   count          = var.private_subnet_count
#   subnet_id      = element(aws_subnet.private.*.id, count.index)
#   route_table_id = aws_route_table.private.id
# }




resource "aws_security_group" "default" {
  vpc_id = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc-Cidr

  tags = {
    Name = "${var.project}-vpc"
  }
}

# Create Public subnet 1
resource "aws_subnet" "Public_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/20"
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.project}-public-subnet-1"
  }
}

# Create Public subnet 2
resource "aws_subnet" "Public_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.16.0/20"
  availability_zone = "us-east-1b"

  tags = {
    Name = "${var.project}-public-subnet-2"
  }
}

# Create Public subnet 3
resource "aws_subnet" "Public_subnet_3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.32.0/20"
  availability_zone = "us-east-1c"

  tags = {
    Name = "${var.project}-public-subnet-3"
  }
}

# Create Private subnet 1
resource "aws_subnet" "Private_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.128.0/20"
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.project}-private-subnet-1"
  }
}

# Create Private subnet 2
resource "aws_subnet" "Private_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.144.0/20"
  availability_zone = "us-east-1b"

  tags = {
    Name = "${var.project}-private-subnet-2"
  }
}

# Create Private subnet 3
resource "aws_subnet" "Private_subnet_3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.160.0/20"
  availability_zone = "us-east-1c"

  tags = {
    Name = "${var.project}-private-subnet-3"
  }
}

# Create EIP
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.project}-nat-eip"
    }

    depends_on = [aws_internet_gateway.gw]

}
# Create a Nat Gateway
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.Public_subnet_1.id

  tags = {
    Name = "${var.project}-NAT-gateway"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}
# Create internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project}-igw"
  }
}

# Create Public route table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.project}-public-rt"
  }
}

resource "aws_route_table_association" "Public_subnet_1" {
  subnet_id      = aws_subnet.Public_subnet_1.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "Public_subnet_2" {
  subnet_id      = aws_subnet.Public_subnet_2.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "Public_subnet_3" {
  subnet_id      = aws_subnet.Public_subnet_3.id
  route_table_id = aws_route_table.main.id
}

# Create Private route tables
resource "aws_route_table" "private_route_1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "${var.project}-private-rt-1"
  }
}

resource "aws_route_table" "private_route_2" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "${var.project}-private-rt-2"
  }
}

resource "aws_route_table" "private_route_3" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "${var.project}-private-rt-3"
  }
}



resource "aws_route_table_association" "Private_subnet_1" {
  subnet_id      = aws_subnet.Private_subnet_1.id
  route_table_id = aws_route_table.private_route_1.id
}

resource "aws_route_table_association" "Private_subnet_2" {
  subnet_id      = aws_subnet.Private_subnet_2.id
  route_table_id = aws_route_table.private_route_2.id
}

resource "aws_route_table_association" "Private_subnet_3" {
  subnet_id      = aws_subnet.Private_subnet_3.id
  route_table_id = aws_route_table.private_route_3.id
}
provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block          = var.vpc_cidr_block
  enable_dns_support  = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidr_block
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet"
  }
}

resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id
  key_name      = var.key_name

  tags = {
    Name = "example-instance"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = var.s3_bucket_name
  acl    = "private"
}

resource "aws_db_instance" "example" {
  identifier           = var.rds_instance_identifier
  allocated_storage    = 20
  engine               = var.rds_engine
  instance_class       = var.rds_instance_class
  name                 = "exampledb"
  username             = var.rds_username
  password             = var.rds_password
  publicly_accessible  = false
  storage_type         = "gp2"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds.id]

  tags = {
    Name = "example-rds"
  }
}

resource "aws_security_group" "rds" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
    cidr_blocks = [aws_subnet.private.cidr_block]
  }
}

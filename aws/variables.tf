variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr_block" {
  description = "CIDR block for private subnet"
  default     = "10.0.2.0/24"
}

variable "ami" {
  description = "AMI ID for EC2 instance"
  default     = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name for EC2 instance"
  default     = "your-key-pair"
}

variable "s3_bucket_name" {
  description = "Name for the S3 bucket"
  default     = "your-s3-bucket"
}

variable "rds_instance_identifier" {
  description = "Identifier for the RDS instance"
  default     = "your-rds-instance"
}

variable "rds_engine" {
  description = "Database engine for RDS instance"
  default     = "postgres"
}

variable "rds_instance_class" {
  description = "Instance class for RDS instance"
  default     = "db.t2.micro"
}

variable "rds_username" {
  description = "Username for RDS instance"
  default     = "your-db-username"
}

variable "rds_password" {
  description = "Password for RDS instance"
  default     = "your-db-password"
}

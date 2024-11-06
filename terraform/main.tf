# Data block to use the default VPC
data "aws_vpc" "default" {
  default = true
}
# Create a public subnet in the default VPC
resource "aws_subnet" "public_subnet" {
  vpc_id                  = data.aws_vpc.default.id
  cidr_block              = "172.31.100.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2a"
}

# Create a private subnet in the default VPC
resource "aws_subnet" "private_subnet" {
  vpc_id            = data.aws_vpc.default.id
  cidr_block        = "172.31.101.0/24"
  availability_zone = "eu-west-2b"
}

# Security group 
resource "aws_security_group" "web-sg" {
    vpc_id = data.aws_vpc.default.id
    name = "web_sg"
}

# Allow HTTP 
resource "aws_vpc_security_group_ingress_rule" "http_ingress" {
    ip_protocol       = "tcp"
    description = "Allow HTTP"
    security_group_id = aws_security_group.web-sg.id
    from_port = 80
    to_port = 80
    cidr_ipv4 = "0.0.0.0/0"
}

#Allow SSH
resource "aws_vpc_security_group_ingress_rule" "ssh_ingress" {
    security_group_id = aws_security_group.web-sg.id
    ip_protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_ipv4 = "0.0.0.0/0"
}

#Allow egress
resource "aws_vpc_security_group_egress_rule" "all_egress" {
    security_group_id = aws_security_group.web-sg.id
    ip_protocol = "-1"
    cidr_ipv4 = "0.0.0.0/0"
}

# Create t2.micro ec2 instance
resource "aws_instance" "web_instance" {
  ami                    = "ami-03c6b308140d10488" 
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "WebServer"
  }
}

# Output instance details
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.web_instance.id
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web_instance.public_ip
}
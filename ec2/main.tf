resource "aws_instance" "web" {
  ami                         = "ami-04b70fa74e45c3917" # Replace with a valid AMI ID
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.vpc_security_group_ids
  iam_instance_profile        = var.instance_profile_name

  tags = {
    Name = "WebServerInstance"
  }
}

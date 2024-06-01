output "web_server_sg_id" {
  value = aws_security_group.web_server.id
}

output "rds_sg_id" {
  value = aws_security_group.rds.id
}

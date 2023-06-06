output "subnet_id" {
  value = aws_subnet.public[0].id
}

output "vpc_id" {
  value = aws_vpc.vpcx.id
}

output "ec2_security_group" {
  value = aws_security_group.ec2.id
}

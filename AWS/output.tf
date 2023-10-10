output "instance_public_ip" {
  value = module.ec2_instance.instance_public_ip
}

output "instance_state" {
  value = module.ec2_instance.instance_state
}

output "subnet_data" {
  value = data.aws_subnet.frankfurt_public_subnet_1
}
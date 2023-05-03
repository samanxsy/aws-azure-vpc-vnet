output "instance1_id" {
  value = aws_instance.instancex1.id
}

output "instance2_id" {
  value = aws_instance.instancex2.id
}

output "instance_public_ip1" {
  value = aws_instance.instancex1.public_ip
}

output "instance_public_ip2" {
  value = aws_instance.instancex2.public_ip
}

output "instance_state1" {
  value = aws_instance.instancex1.instance_state
}

output "instance_state2" {
  value = aws_instance.instancex2.instance_state
}

output "instance_public_ip" {
    value = module.ec2-instance.instance_id
}

output "instance_state" {
    value = module.ec2-instance.instance_state
    description = "The state of the server instance."
}
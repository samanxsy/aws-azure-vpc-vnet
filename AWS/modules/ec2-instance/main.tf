resource "aws_instance" "instancex" {
    ami = var.machine_image
    instance_type = var.instance_type
    availability_zone = var.aws_instance_azs
    subnet_id = var.aws_subnet_id
    associate_public_ip_address = true
    vpc_security_group_ids = [module.security-group.http_https_sgx_id, module.security-group.ssh_sgx_id]
    tags = {
        Name = var.aws_instance_name
        Group = "variablex"
    }
}

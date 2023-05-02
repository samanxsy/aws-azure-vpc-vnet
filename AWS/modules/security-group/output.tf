output "htto_httpx_sgx_id" {
    value = aws_security_group.http_https_sgx.id
}

output "ssh_sgx_id" {
    value = aws_security_group.ssh_sgx.id
}

# AWS Key Pair
#
# Output

output "ssh_key_name" {
  value = aws_key_pair.ssh_pair.key_name
}

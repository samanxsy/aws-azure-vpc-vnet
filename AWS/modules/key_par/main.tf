# AWS Key Pair
#
# Main Terraform Config


resource "aws_key_pair" "ssh_pair" {
  key_name   = "ec2key"
  public_key = file("modules/ec2_instance/ec2key.pub")
}

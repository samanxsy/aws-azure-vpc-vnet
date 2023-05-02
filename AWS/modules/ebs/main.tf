resource "aws_ebs_volume" "volumex" {
    availability_zone = var.ebs_azs
    size = 20
    tag = {
        Group = "variablex"
    }
}

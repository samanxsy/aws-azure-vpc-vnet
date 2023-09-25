# Modules
module "tfplan-functions" {
  source = ""
}

module "aws-functions" {
  source = "./modules"
}


# Policies
policy "restrict-ec2-instance-type" {
  source = "./restrict-ec2-type.sentinel"
  enforcement_level = "hard-mandatory"
}

policy "enforce-mandatory-tags" {
  source = "./mandatory-tags.sentinel"
  enforcement_level = "advisory"
}

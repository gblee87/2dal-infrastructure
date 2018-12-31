module "vpc" {
  source = "github.com/asbubam/2dal-infrastructure/terraform/modules/cheap_vpc"

  name = "dev"
  cidr = "172.16.0.0/16"

  azs              = ["ap-northeast-1a", "ap-northeast-1c"]
  public_subnets   = ["172.16.1.0/24", "172.16.2.0/24"]
  private_subnets  = ["172.16.101.0/24", "172.16.102.0/24"]
  database_subnets = ["172.16.201.0/24", "172.16.202.0/24"]

  bastion_ami                 = "${data.aws_ami.amazon_linux_nat.id}"
  bastion_availability_zone   = "${module.vpc.azs[0]}"
  bastion_subnet_id           = "${module.vpc.public_subnets_ids[0]}"
  bastion_ingress_cidr_blocks = "${var.office_cidr_blocks}"
  bastion_keypair_name        = "${var.keypair_name}"

  tags = {
    "TerraformManaged" = "true"
  }
}

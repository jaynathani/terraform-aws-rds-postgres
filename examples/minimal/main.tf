module "rds_postgres" {
  # source               = "git::https://github.com/Datatamer/terraform-aws-rds-postgres.git?ref=0.4.0"
  source = "../.."

  identifier_prefix    = "example-rds-pg-"
  postgres_name        = "example0"
  parameter_group_name = "example-rds-postgres-pg"
  username             = "example-tamr-master"
  password             = "foo" #tfsec:ignore:GEN003

  vpc_id            = var.vpc_id
  subnet_group_name = "example_subnet_group"
  # Network requirement: DB subnet group needs a subnet in at least two Availability Zones
  rds_subnet_ids = var.subnet_ids
  ingress_sg_ids = var.ingress_sg_ids
}

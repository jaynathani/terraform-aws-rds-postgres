resource "aws_security_group" "rds_postgres_sg" {
  name        = var.security_group_name
  description = "VPC Security group that will be attached to the RDS Postgres instance"
  vpc_id      = var.vpc_id
  tags        = var.additional_tags
}

resource "aws_security_group_rule" "pg_ingress" {
  description              = "Ingress rule to Postgres DB instance."
  count                    = length(var.ingress_sg_ids)
  from_port                = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_postgres_sg.id
  to_port                  = 5432
  type                     = "ingress"
  source_security_group_id = var.ingress_sg_ids[count.index]
}

resource "aws_security_group_rule" "additional_cidrs" {
  description       = "Rule for ingress from additional CIDRs to Postgres"
  count             = length(var.additional_cidrs) == 0 ? 0 : 1
  from_port         = 5432
  protocol          = "tcp"
  security_group_id = aws_security_group.rds_postgres_sg.id
  to_port           = 5432
  type              = "ingress"
  cidr_blocks       = var.additional_cidrs
}

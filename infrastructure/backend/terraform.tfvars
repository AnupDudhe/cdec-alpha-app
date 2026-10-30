# Copy to terraform.tfvars. Do not commit terraform.tfvars.

aws_region   = "us-east-1"
environment  = "dev"
project_name = "cdec-alpha"
cluster_name = "cdec-eks-dev"

# VPC — change AZ names for your region
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.20.0/24"]
availability_zones   = ["eu-west-1a", "eu-west-1b"]

single_nat_gateway = true

# EKS
kubernetes_version  = "1.34"
node_instance_types = ["c7i-flex.large"]
desired_size        = 2
min_size            = 1
max_size            = 3

cluster_endpoint_public_access       = true
cluster_endpoint_private_access      = true
cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

cluster_admin_iam_role_names    = []
cluster_admin_principal_arns    = []
include_caller_as_cluster_admin = true

additional_tags = {
  Owner = "platform-team"
}

# ALB Ingress — AWS Load Balancer Controller + API ingress
enable_alb_ingress  = true
ingress_host        = "api.infra-software-architect.online"
acm_certificate_arn = "arn:aws:acm:us-east-1:593402827940:certificate/c7a03da2-5599-4764-82ad-927baff32f0c"
alb_name            = "cdec-alpha-alb"

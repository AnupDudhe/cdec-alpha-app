# Copy to terraform.tfvars. Do not commit terraform.tfvars.

aws_region  = "eu-west-1"
environment = "dev"
application = "cdec-alpha-cbzpb"

acm_certificate_arn = "arn:aws:acm:us-east-1:365642143872:certificate/32fac1bb-a47a-4568-a706-1f24cc8efe31"

# Use a domain you own — example.com is reserved by AWS and will fail
dns_zone_name   = "infra-software-architect.online"
dns_record_name = "www.infra-software-architect.online"

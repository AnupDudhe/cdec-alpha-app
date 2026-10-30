# Copy to terraform.tfvars. Do not commit terraform.tfvars.

aws_region  = "us-east-1"
environment = "dev"
application = "cdec-alpha-cbzpb3738"

acm_certificate_arn = "arn:aws:acm:us-east-1:593402827940:certificate/c7a03da2-5599-4764-82ad-927baff32f0c"

# Use a domain you own — example.com is reserved by AWS and will fail
dns_zone_name   = "infra-software-architect.online"
dns_record_name = "www.infra-software-architect.online"

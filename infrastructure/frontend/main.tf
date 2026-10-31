# Frontend stack — S3 + CloudFront for the Vite/React SPA

locals {
  # Use explicit aliases when set; otherwise derive from dns_record_name so SSL/DNS stay in sync.
  cloudfront_aliases = length(var.cloudfront_aliases) > 0 ? var.cloudfront_aliases : (
    var.dns_record_name != "" ? [var.dns_record_name] : []
  )
}

check "acm_certificate_with_custom_domain" {
  assert {
    condition     = length(local.cloudfront_aliases) == 0 || var.acm_certificate_arn != null
    error_message = "acm_certificate_arn must be set when cloudfront_aliases or dns_record_name configures a custom domain."
  }
}

module "cloudfront" {
  source = "../modules/cloudfront"

  application = var.application
  environment = var.environment

  bucket_name       = var.bucket_name
  force_destroy     = var.force_destroy
  enable_versioning = var.enable_versioning

  aliases             = local.cloudfront_aliases
  #aliases = []
  acm_certificate_arn = var.acm_certificate_arn
  enable_spa_routing  = var.enable_spa_routing

  tags = {
    Component = "cloudfront"
  }
}

module "route53" {
  source = "../modules/route53"

  application = var.application
  environment = var.environment

  zone_name     = var.dns_zone_name
  zone_id       = var.route53_zone_id
  force_destroy = var.dns_zone_force_destroy

  records = var.dns_record_name != "" ? [
    {
      name = var.dns_record_name
      type = "A"
      alias = {
        name    = module.cloudfront.domain_name
        zone_id = module.cloudfront.hosted_zone_id
      }
    },
    {
      name = var.dns_record_name
      type = "AAAA"
      alias = {
        name    = module.cloudfront.domain_name
        zone_id = module.cloudfront.hosted_zone_id
      }
    },
  ] : []

  tags = {
    Component = "route53"
  }
}

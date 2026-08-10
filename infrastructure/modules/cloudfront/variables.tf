variable "application" {
  description = "Application identifier used in naming and tags."
  type        = string
}

variable "environment" {
  description = "Environment name used in naming and tags."
  type        = string
}

variable "name_prefix" {
  description = "Override for resource name prefix. Defaults to {application}-{environment}."
  type        = string
  default     = null
}

variable "bucket_name" {
  description = "S3 bucket name for frontend assets. Must be globally unique. Defaults to {name_prefix}-frontend."
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "Allow Terraform to delete the bucket even when it contains objects."
  type        = bool
  default     = false
}

variable "enable_versioning" {
  description = "Enable S3 object versioning on the frontend bucket."
  type        = bool
  default     = false
}

variable "enabled" {
  description = "Whether the CloudFront distribution is enabled."
  type        = bool
  default     = true
}

variable "comment" {
  description = "Comment shown in the AWS console for this distribution."
  type        = string
  default     = null
}

variable "aliases" {
  description = "Alternate domain names (CNAMEs) for this distribution, e.g. [\"www.example.com\"]. Requires acm_certificate_arn."
  type        = list(string)
  default     = []
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN in us-east-1 for custom domain names. Required when aliases is non-empty."
  type        = string
  default     = null
}

variable "default_root_object" {
  description = "Object returned for root URL requests, e.g. index.html."
  type        = string
  default     = "index.html"
}

variable "enable_spa_routing" {
  description = "Return index.html with HTTP 200 for 403/404 errors (client-side routing)."
  type        = bool
  default     = true
}

variable "viewer_protocol_policy" {
  description = "Protocol policy for viewers."
  type        = string
  default     = "redirect-to-https"

  validation {
    condition     = contains(["allow-all", "https-only", "redirect-to-https"], var.viewer_protocol_policy)
    error_message = "viewer_protocol_policy must be allow-all, https-only, or redirect-to-https."
  }
}

variable "allowed_methods" {
  description = "HTTP methods CloudFront processes for the default cache behavior."
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "cached_methods" {
  description = "HTTP methods CloudFront caches for the default cache behavior."
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "cache_policy_id" {
  description = "Managed cache policy ID. Defaults to AWS CachingOptimized if null."
  type        = string
  default     = null
}

variable "compress" {
  description = "Whether CloudFront compresses objects for viewers that support it."
  type        = bool
  default     = true
}

variable "price_class" {
  description = "Price class for the distribution."
  type        = string
  default     = "PriceClass_100"

  validation {
    condition     = contains(["PriceClass_All", "PriceClass_200", "PriceClass_100"], var.price_class)
    error_message = "price_class must be PriceClass_All, PriceClass_200, or PriceClass_100."
  }
}

variable "geo_restriction_type" {
  description = "Geo restriction type: none, whitelist, or blacklist."
  type        = string
  default     = "none"
}

variable "geo_restriction_locations" {
  description = "ISO 3166-1-alpha-2 country codes when using whitelist or blacklist."
  type        = list(string)
  default     = []
}

variable "minimum_protocol_version" {
  description = "Minimum TLS version when using a custom ACM certificate."
  type        = string
  default     = "TLSv1.2_2021"
}

variable "tags" {
  description = "Additional tags applied to S3 and CloudFront resources."
  type        = map(string)
  default     = {}
}

variable "org_name" {
  description = "The Okta organization name"
  type        = string
}

variable "base_url" {
  description = "The base URL for Okta"
  type        = string
}

variable "root_client_id" {
  description = "The client ID for Okta"
  type        = string
}

variable "root_private_key" {
  description = "The private key for Okta"
  type        = string
}

variable "scopes" {
  description = "The scopes for Okta"
  type        = list(string)
}

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

variable "iz_resource_set_scopes" {
  description = "The scopes for Okta"
  type        = list(string)
}

variable "iz_client_id" {
  type        = string
  description = "Client ID for IZ"
}

variable "app_pattern_client_id" {
  type        = string
  description = "Client ID for App Pattern"
}

terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "4.6.3"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
    jwks = {
      source  = "iwarapter/jwks"
      version = "0.1.0"
    }
  }
}

provider "okta" {
  org_name    = var.org_name
  base_url    = var.base_url
  client_id   = var.root_client_id
  private_key = file("../${var.root_private_key}")
  scopes      = var.scopes
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

data "jwks_from_key" "jwks" {
  key = tls_private_key.rsa.private_key_pem
  kid = "kid"
}

resource "local_file" "private_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "${path.module}/iz.pem"
}

locals {
  jwks = jsondecode(data.jwks_from_key.jwks.jwks)
}

resource "okta_app_oauth" "iz_api_app" {
  label                      = "IZ API App"
  type                       = "service"
  grant_types                = ["client_credentials"]
  token_endpoint_auth_method = "private_key_jwt"

  jwks {
    kty = local.jwks.kty
    kid = local.jwks.kid
    e   = local.jwks.e
    n   = local.jwks.n
  }
}

resource "okta_app_oauth_api_scope" "iz_api_scope_assignment" {
  app_id = okta_app_oauth.iz_api_app.id
  issuer = local.issuer
  scopes = var.scopes
}

output "iz_api_app_client_id" {
  value = okta_app_oauth.iz_api_app.client_id
}

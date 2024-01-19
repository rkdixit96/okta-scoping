terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "4.6.3"
    }
  }
}

provider "okta" {
  org_name = var.org_name
  base_url = var.base_url
  scopes   = var.app_pattern_scopes

  # Creation/Deletion
  client_id   = var.root_client_id
  private_key = file("../${var.root_private_key}")

  # Updation
  # client_id   = var.iz_client_id
  # private_key = file("../iz/${var.iz_private_key}")
}

resource "okta_app_oauth" "app_pattern" {
  label         = "App pattern"
  type          = "web"
  grant_types   = ["authorization_code"]
  redirect_uris = ["https://test.com/callback/updated"]
}

output "iz_app_pattern_client_id" {
  value = okta_app_oauth.app_pattern.client_id
}

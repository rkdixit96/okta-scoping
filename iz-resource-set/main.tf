terraform {
  required_version = "1.6.6"
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "4.6.3"
    }
  }
}

provider "okta" {
  org_name    = var.org_name
  base_url    = var.base_url
  scopes      = var.iz_resource_set_scopes
  client_id   = var.root_client_id
  private_key = file("../${var.root_private_key}")
}

# Requires atleast 1 resource and needs "okta.roles.manage" scope
resource "okta_resource_set" "iz_resource_set" {
  description = "IZ Resource Set"
  label       = "IZ Resource Set"
  resources = [
    format("%s/api/v1/apps/%s", local.resource_base_url, var.app_pattern_client_id),
  ]
}

resource "okta_admin_role_custom" "iz_admin_role" {
  label       = "IZ Admin Role"
  description = "IZ Admin Role"
  permissions = ["okta.apps.manage", "okta.groups.manage"]
}

resource "okta_app_oauth_role_assignment" "iz_admin_role_assignment" {
  type         = "CUSTOM"
  client_id    = var.iz_client_id
  role         = okta_admin_role_custom.iz_admin_role.id
  resource_set = okta_resource_set.iz_resource_set.id
}

# Terraform Automation for Okta
## Pre-requisites
1. Create a developer account in [Okta](https://developer.okta.com/signup/)
2. Create an OAuth application in Okta and grant it scopes for Okta API - okta.apps.manage, okta.appGrants.manage, okta.roles.manage, okta.groups.manage
3. Change client authentication to Public Key/Private Key (Use the inbuilt functionality and save the private key as secret.pem)

## Steps to run
1. IZ Creation
   1. Credentials - Uses root credentials
   2. Workflow - iz/main.tf
   3. Steps
      1. Creates IZ Okta API application
   4. Output - Okta API application client ID
2. App Pattern Creation
   1. Credentials - Uses root credentials
   2. Workflow - app-pattern/main.tf
   3. Steps
      1. Creates OAuth Okta application
   4. Output
      1. Okta OAuth application client ID
3. Create IZ resource set and bind OAuth to resource set (Has to be done together because resource set requires atleast one application to be created and does not let you add a resource to it in a granular fashion)
   1. Credntials - Uses root credentials
   2. Workflow - iz-resource-set/main.tf
   3. Steps
      1. Create Resource set and with OAuth created in 2.2.1
      2. Create an IZ role
      3. Assign IZ role and Resource set to API application created in 1.2.1
4. App Pattern Updation (Cannot Delete)
   1. Credentials - Uses IZ credentials
   2. Workflow - app-pattern/main.tf
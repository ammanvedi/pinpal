terraform {
  required_version = ">= 1.1.0"
  backend "remote" {
    organization = "root_org"
    workspaces {
      name = "dev"
    }
  }

  required_providers {
    auth0 = {
      source = "auth0/auth0"
      version = "0.30.3"
    }
  }
}

provider "auth0" {
  domain = var.auth0_domain
  client_id = var.auth0_client_id
  client_secret = var.auth0_client_secret
  debug = true
}

module "auth0" {
  source = "../../modules/auth0"
  web_client_name = "web-dev"

  auth0_callback_urls = ["http://localhost:3000"]
  auth0_allowed_origins = ["http://localhost:3000"]
  auth0_logout_urls = ["http://localhost:3000"]
  auth0_google_client_id = var.auth0_google_client_id
  auth0_google_client_secret = var.auth0_google_client_secret
}
terraform {
  required_version = ">= 1.1.0"
  backend "remote" {
    organization = "root_org"
    workspaces {
      name = "prod"
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
  web_client_name = "web-prod"

  auth0_callback_urls = ["https://pinpal.io"]
  auth0_allowed_origins = ["https://pinpal.io"]
  auth0_logout_urls = ["https://pinpal.io"]
  auth0_google_client_id = var.auth0_google_client_id
  auth0_google_client_secret = var.auth0_google_client_secret
}

module "cloudflare" {
  source = "../../modules/cloudflare"


}
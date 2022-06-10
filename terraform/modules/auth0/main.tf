terraform {
  required_providers {
    auth0 = {
      source = "auth0/auth0"
      version = "0.30.3"
    }
  }
}

resource "auth0_client" "web" {
  name = var.web_client_name
  app_type = "spa"
  callbacks = var.auth0_callback_urls
  allowed_logout_urls = var.auth0_logout_urls
  allowed_origins = var.auth0_allowed_origins
  web_origins = var.auth0_allowed_origins
  jwt_configuration {
    alg = "RS256"
  }
  token_endpoint_auth_method = "none"
  grant_types = [
    "authorization_code",
    "implicit",
    "refresh_token",
  ]
}

resource "auth0_connection" "auth0-social-login-google" {
  name = "auth0-social-login-google"
  strategy = "google-oauth2"
  enabled_clients = [auth0_client.web.id]
  options {
    scopes = ["email", "profile"]
    client_id = var.auth0_google_client_id
    client_secret = var.auth0_google_client_secret
  }
}
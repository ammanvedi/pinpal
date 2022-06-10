variable "web_client_name" {
  type = string
}

variable "auth0_callback_urls" {
  type = list(string)
}


variable "auth0_logout_urls" {
  type = list(string)
}

variable "auth0_allowed_origins" {
  type = list(string)
}

variable "auth0_google_client_id" {
  type = string
}

variable "auth0_google_client_secret" {
  type = string
}
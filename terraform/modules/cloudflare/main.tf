terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "3.16.0"
    }
  }
}

provider "cloudflare" {
  email: var.cloudflare_email
  api_key = var.cloudflare_api_key
}

resource "cloudflare_worker_script" "" {
  content = ""
  name    = ""
}

resource "cloudflare_tr"
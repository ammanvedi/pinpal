terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "3.16.0"
    }
  }
}

provider "cloudflare" {
  account_id = var.cloudflare_account_id
  email = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

resource "cloudflare_worker_script" "serve_app_worker" {
  name = "serve_app_worker"
  content = file("${path.module}/../../../dist/cloudflare-worker/serve-app.bundle.js")
  kv_namespace_binding {
    name         = "ASSETS"
    namespace_id = cloudflare_workers_kv_namespace.app_files.id
  }
}

resource "cloudflare_worker_script" "serve_api_worker" {
  name = "serve_api_worker"
  content = file("${path.module}/../../../dist/cloudflare-worker/serve-api.bundle.js")
}


resource "cloudflare_worker_route" "serve_app_route" {
  zone_id = data.cloudflare_zone.worker_zone.id
  pattern = "${var.cloudflare_worker_domain}/*"
  script_name = cloudflare_worker_script.serve_app_worker.name
}

resource "cloudflare_worker_route" "serve_api_route" {
  zone_id = data.cloudflare_zone.worker_zone.id
  pattern = "api.${var.cloudflare_worker_domain}/*"
  script_name = cloudflare_worker_script.serve_api_worker.name
}

data "cloudflare_zone" "worker_zone" {
  name = var.cloudflare_worker_domain
  account_id = var.cloudflare_account_id
}

resource "cloudflare_workers_kv_namespace" "app_files" {
  title = "app_files"
}

resource "cloudflare_workers_kv" "app_file" {
  for_each = fileset("${path.module}/../../../dist/web", "*")
  namespace_id = cloudflare_workers_kv_namespace.app_files.id
  key          = each.value
  value        = file("${path.module}/../../../dist/web/${each.value}")
}

resource "cloudflare_workers_kv" "app_asset_file" {
  for_each = fileset("${path.module}/../../../dist/web/assets", "*")
  namespace_id = cloudflare_workers_kv_namespace.app_files.id
  key          = "assets/${each.value}"
  value        = file("${path.module}/../../../dist/web/assets/${each.value}")
}
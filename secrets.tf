resource "vault_mount" "this" {
  count              = var.nomad_addr != "" ? 1 : 0
  path               = "${local.safe_namespace}/${var.job_name}"
  type               = "kv"
  options            = { version = "2" }
  description        = "KV Version 2 secret engine mount"
  listing_visibility = "hidden"
}

resource "vault_kv_secret_v2" "this" {
  for_each     = toset(var.secret_paths)
  mount        = vault_mount.this.path
  name         = each.value
  data_json    = jsonencode({})
  disable_read = true
}
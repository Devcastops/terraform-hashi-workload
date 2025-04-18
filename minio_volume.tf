# It can sometimes be helpful to wait for a particular plugin to be available
data "nomad_plugin" "minio" {
  count            = var.minio_volume_required ? 1 : 0
  plugin_id        = "minio0"
  wait_for_healthy = true
}

resource "nomad_csi_volume" "minio" {
  count     = var.minio_volume_required ? 1 : 0
  namespace = local.safe_namespace

  plugin_id    = data.nomad_plugin.minio[0].plugin_id
  volume_id    = var.job_name
  name         = "${local.safe_namespace}-${var.job_name}"
  capacity_min = var.volume_capacity
  capability {
    access_mode     = "multi-node-multi-writer"
    attachment_mode = "file-system"
  }
  secrets = {
    accessKeyID     = var.minio_access_key
    secretAccessKey = var.minio_secret_key
    endpoint        = var.minio_endpoint
  }
  parameters = {
    mounter = "s3fs"
  }
  lifecycle {
    prevent_destroy = false
  }
}

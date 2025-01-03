# It can sometimes be helpful to wait for a particular plugin to be available
data "nomad_plugin" "gcp" {
  count     = var.gcp_volume_required ? 1 : 0
  plugin_id        = "gcp-gce0"
  wait_for_healthy = true
}

resource "nomad_csi_volume" "this" {
  count     = var.gcp_volume_required ? 1 : 0
  namespace = local.safe_namespace

  plugin_id    = data.nomad_plugin.gcp[0].plugin_id
  volume_id    = var.job_name
  name         = "${local.safe_namespace}-${var.job_name}"
  capacity_min = var.volume_capacity
  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }
  topology_request {
    preferred {
      topology {
        segments = {
          "topology.gke.io/zone" = "europe-west2-a"
        }
      }
    }
  }
  lifecycle {
    prevent_destroy = false
  }
}

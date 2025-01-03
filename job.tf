resource "nomad_job" "run" {
  jobspec = var.job_spec
  hcl2 {
    vars = merge({
      namespace = local.safe_namespace
    },{})
  }
}

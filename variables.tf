variable "vault_addr" {
  type        = string
  default     = ""
  description = "The address for the vault cluster"
}

variable "nomad_addr" {
  type        = string
  description = "The address for the nomad cluster"
}

variable "job_name" {
  type = string
}

variable "job_spec" {
  type = string
}

variable "namespace" {
  type    = string
  default = "default"
}

variable "gcp_volume_required" {
  type    = bool
  default = false
}

variable "volume_capacity" {
  type    = string
  default = "10GiB"
}

variable "secret_paths" {
  type    = list(string)
  default = []
}
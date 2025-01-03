locals {
  safe_namespace = replace(var.namespace, "/", "-")
}
output "config_map" {
  value = "${data.template_file.aws_auth_cm.rendered}"
}

output "kubeconfig" {
  value = "${local.kubeconfig_path}"
}

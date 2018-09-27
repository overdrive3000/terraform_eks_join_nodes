variable "cluster_name" {}
variable "region" {}
variable "cluster_endpoint" {}
variable "cluster_ca" {}
variable "role" {}

variable "kubeconfig" {
  type    = "string"
  default = "~/.kube/"
}

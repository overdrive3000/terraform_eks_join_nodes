locals {
  kubeconfig_path = "${pathexpand("${var.kubeconfig}/${var.cluster_name}-${var.region}")}"
}

data "template_file" "aws_auth_cm" {
  template = "${file("${path.module}/templates/aws-auth-cm.tpl")}"

  vars {
    rolearn = "${var.role}"
  }
}

data "template_file" "kubeconfig" {
  template = "${file("${path.module}/templates/kubeconfig.tpl")}"

  vars {
    endpoint     = "${var.cluster_endpoint}"
    ca           = "${var.cluster_ca}"
    cluster_name = "${var.cluster_name}"
    region       = "${var.region}"
  }
}

resource "local_file" "kubeconfig" {
  content  = "${data.template_file.kubeconfig.rendered}"
  filename = "${local.kubeconfig_path}"
}

resource "local_file" "aws_auth_cm" {
  content  = "${data.template_file.aws_auth_cm.rendered}"
  filename = "/tmp/aws-auth-cm.yaml"
}

resource "null_resource" "join_cluster" {
  provisioner "local-exec" {
    command = "kubectl --kubeconfig=${local.kubeconfig_path} apply -f /tmp/aws-auth-cm.yaml"
  }

  depends_on = [
    "local_file.aws_auth_cm",
    "local_file.kubeconfig",
  ]
}

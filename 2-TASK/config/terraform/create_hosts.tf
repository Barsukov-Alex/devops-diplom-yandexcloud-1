resource "local_file" "hosts_yml_kubespray" {

  content  = templatefile("${path.module}/hosts.tftpl", {
    workers = yandex_compute_instance.worker-node
    masters = yandex_compute_instance.master-node
  })
  filename = "../ansible/inventory/hosts.yml"
}
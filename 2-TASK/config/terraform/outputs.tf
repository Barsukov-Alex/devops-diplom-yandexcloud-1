output "master-node" {
  value = flatten([
    [for i in yandex_compute_instance.master-node : {
      name = i.name
      ip_external   = i.network_interface[0].nat_ip_address
      ip_internal = i.network_interface[0].ip_address
    }],
  ])
}

output "worker-node" {
  value = flatten([
    [for i in yandex_compute_instance.worker-node : {
      name = i.name
      ip_external   = i.network_interface[0].nat_ip_address
      ip_internal = i.network_interface[0].ip_address
    }],
  ])
}
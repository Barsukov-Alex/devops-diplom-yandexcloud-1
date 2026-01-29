# Ресурсы для создания worker-node

resource "yandex_compute_instance" "worker-node" {
  name        = "${var.yandex_compute_instance_worker[0].vm_name}-${count.index+1}"
  platform_id = var.yandex_compute_instance_worker[0].platform_id

  count = var.yandex_compute_instance_worker[0].count_vms

  resources {
    cores         = var.yandex_compute_instance_worker[0].cores
    memory        = var.yandex_compute_instance_worker[0].memory
    core_fraction = var.yandex_compute_instance_worker[0].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.debian.image_id
      type     = var.boot_disk_worker[0].type
      size     = var.boot_disk_worker[0].size
    }
  }

  metadata = {
    ssh-keys = "debian:${local.ssh-keys}"
    serial-port-enable = "1"
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-a.id
    nat       = true
  }
  scheduling_policy {
    preemptible = true
  }
}
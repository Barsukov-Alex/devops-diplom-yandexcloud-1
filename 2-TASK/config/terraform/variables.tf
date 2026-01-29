#cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "account_name" {
  type        = string
  default     = "barsukov-nv"
  description = "account_name"
}



variable "vpc_name" {
  type        = string
  default     = "vpc0"
  description = "VPC network"
}

variable "subnet-a" {
  type        = string
  default     = "subnet-a"
  description = "subnet name"
}

variable "subnet-b" {
  type        = string
  default     = "subnet-b"
  description = "subnet name"
}

variable "subnet-d" {
  type        = string
  default     = "subnet-d"
  description = "subnet name"
}

variable "zone-a" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "zone-b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "zone-d" {
  type        = string
  default     = "ru-central1-d"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "cidr-a" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "cidr-b" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "cidr-d" {
  type        = list(string)
  default     = ["10.0.3.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}


# Переменные для ВМ

#ssh
locals {
    ssh-keys = file("~/.ssh/id_rsa.pub")
}

variable "os_image_node" {
  type    = string
  default = "debian-12"
}


# Переменные для master-node

variable "yandex_compute_instance_web" {
  type        = list(object({
    vm_name = string
    cores = number
    memory = number
    core_fraction = number
    count_vms = number
    platform_id = string
  }))

  default = [{
      vm_name = "master"
      cores         = 2
      memory        = 4
      core_fraction = 20
      count_vms = 1
      platform_id = "standard-v1"
    }]
}

variable "boot_disk_web" {
  type        = list(object({
    size = number
    type = string
    }))
    default = [ {
    size = 30
    type = "network-hdd"
  }]
}


# Переменные для worker-node

variable "yandex_compute_instance_worker" {
  type        = list(object({
    vm_name = string
    cores = number
    memory = number
    core_fraction = number
    count_vms = number
    platform_id = string
  }))

  default = [{
      vm_name = "worker"
      cores         = 4
      memory        = 6
      core_fraction = 20
      count_vms = 2
      platform_id = "standard-v1"
    }]
}

variable "boot_disk_worker" {
  type        = list(object({
    size = number
    type = string
    }))
    default = [ {
    size = 30
    type = "network-hdd"
  }]
}
# Создание сервисного аккаунта для Terraform
resource "yandex_iam_service_account" "service" {
  name      = var.account_name
  description = "service account to manage VMs"
  folder_id = var.folder_id
}

# Назначение роли editor сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.service.id}"
  depends_on = [yandex_iam_service_account.service]
}

# Создание статического ключа доступа для сервисного аккаунта
resource "yandex_iam_service_account_static_access_key" "terraform_service_account_key" {
  service_account_id = yandex_iam_service_account.service.id
  description        = "static access key for object storage"
}

# Создадим бакет с использованием ключа
resource "yandex_storage_bucket" "state_storage" {
  bucket     = local.bucket_name
  access_key = yandex_iam_service_account_static_access_key.terraform_service_account_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.terraform_service_account_key.secret_key

  anonymous_access_flags {
    read = false
    list = false
  }
}

# Локальная переменная отвечающая за текущую дату в названии бакета
locals {
    current_timestamp = timestamp()
    formatted_date = formatdate("DD-MM-YYYY", local.current_timestamp)
    bucket_name = "state-storage-${local.formatted_date}"
}
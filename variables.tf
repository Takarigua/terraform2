
variable "cloud_id" {
  type        = string
  description = "Yandex Cloud ID"
}

variable "folder_id" {
  type        = string
  description = "Yandex Cloud Folder ID"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Default zone"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "CIDR block for subnet"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "Network name"
}


variable "vms_ssh_key_path" {
  type        = string
  description = "Path to SSH public key file"
}

variable "service_account_key_file" {
  type        = string
  description = "Path to service account key file"
}

variable "vm_web_name" {
  type    = string
  default = "netology-develop-platform-web"
}

variable "vm_web_platform_id" {
  type    = string
  default = "standard-v1"
}

#variable "vm_web_cores" {
#  type    = number
#  default = 2
#}

#variable "vm_web_memory" {
#  type    = number
#  default = 1
#}

#variable "vm_web_core_fraction" {
#  type    = number
#  default = 5
#}
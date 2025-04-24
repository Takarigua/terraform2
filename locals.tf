locals {
  vm_web_name = "${var.vm_web_name}-${var.default_zone}"
  vm_db_name  = "${var.vm_db_name}-${var.vm_db_zone}"

  metadata = {
    serial-port-enable = "1"
    ssh-keys           = "ubuntu:${file(var.vms_ssh_key_path)}"
  }
}

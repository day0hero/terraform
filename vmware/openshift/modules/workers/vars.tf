variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}


variable "vsphere_vm_name" {
    type = string
}
variable "vm_count" {
    type = string
    description = "Number of VMs"
    default     = 1
}
variable "vm_cpu" {
    default = 2
}
variable "vm_ram" {
    default = 2048
}
variable "vsphere_vm_domain" {
    default = ""
}

variable "vsphere_vm_firmware" {
    default = "efi"
}

variable "vm_folder" {
    default = "vms"
}

variable "hostname" { default = "localhost" }
variable "domain" { default = "localdomain" }
variable "memory" { default = "2048" }
variable "vcpus" { default = "2" }
variable "disk_size" { default = 50*1073741824 }
variable "data_disk1_size" { default = 500*1073741824 }
variable "libvirt_pool" { default = "images" }
variable "image_repo" { default = "/var/lib/libvirt/content" }
variable "base_image" { default = "rhel-8.2-packer.qcow2" }
variable "networks" {
  type = map
  default = {
    "public" = "br99"
    "vmnet"  = "br200"
  }
}

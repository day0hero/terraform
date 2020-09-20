variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}
variable "vsphere_datacenter" {}
variable "vsphere_cluster" {}
variable "vsphere_esxi_hosts" {
  type 	= list(string)
}
variable "vsphere_esxi_username" {
  type 	= string
  default = "root"
}
variable "vsphere_esxi_password" {}

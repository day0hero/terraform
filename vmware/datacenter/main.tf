provider "vsphere" {
  user	= var.vsphere_user
  password = var.vsphere_password
  vsphere_server = var.vsphere_server

  allow_unverified_ssl = true
}

resource "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter
}


provider "vsphere" {
  user       = var.vsphere_user
  password   = var.vsphere_password
  vsphere_server = var.vsphere_server

allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
    name = var.vsphere_datacenter
}

data "vsphere_folder" "vsphere_vm_folder" {
    path = var.vsphere_vm_folder
}
 
data "vsphere_datastore" "datastore" {
    name = var.vsphere_datastore
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
    name = var.vsphere_compute_cluster
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
    name    = var.networks[var.vm_net]
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
    name = "templates/${var.templates[var.vm_template]}"
    datacenter_id = data.vsphere_datacenter.dc.id
}

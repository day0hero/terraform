provider "vsphere" {
  user			= var.vsphere_user
  password 		= var.vsphere_password
  vsphere_server	= var.vsphere_server

  allow_unverified_ssl 	= true
}

data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

resource "vsphere_compute_cluster" "compute_cluster" {
  name		= var.vsphere_cluster_name
  datacenter_id	= "${data.vsphere_datacenter.dc.id}"
  drs_enabled	= var.vsphere_drs
  drs_automation_level = "fullyAutomated"
  ha_enabled	= var.vsphere_ha
}

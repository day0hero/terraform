provider "vsphere" {
  user		= var.vsphere_user
  password	= var.vsphere_password
  vsphere_server = var.vsphere_server

  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_compute_cluster" "cluster" {
  name = var.vsphere_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_host" "host" {
  count		= length(var.vsphere_esxi_hosts)
  hostname 	= var.vsphere_esxi_hosts[count.index]
  username 	= var.vsphere_esxi_username
  password 	= var.vsphere_esxi_password
  thumbprint	= var.vsphere_esxi_thumbprint
  cluster 	= data.vsphere_compute_cluster.cluster.id 
}

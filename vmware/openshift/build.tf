resource "vsphere_folder" "openshift4" {
  path		= var.ocp_clustername
  name 		= "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}

module "loadbalancers" {
  source	= "./modules/loadbalancers"
  folder	= vsphere_folder.cluster.path 

provider "libvirt" {
  uri ="qemu:///system"
}

module "satellite" {
  source = "./modules/satellite"

  hostname		= var.hostname
  domain		= var.domain
  memory		= var.memory
  vcpus			= var.vcpus
  libvirt_pool		= var.libvirt_pool
  base_image		= var.base_image
  image_repo    	= var.image_repo
  disk_size		= var.disk_size
  data_disk     	= true
  data_disk1_size    	= var.data_disk1_size
  multiple_network	= true
}

/*
module "idm" {
  source = "./modules/idm"

  hostname 		= var.hostname
  domain		= var.domain
  memory		= var.memory
  vcpus			= var.vcpus
  libvirt_pool		= var.libvirt_pool
  base_image		= var.base_image
  image_repo    	= var.image_repo
  disk_size		= var.disk_size
}
*/
module "demo" {
  source = "./modules/demo"

  hostname              = var.hostname
  domain                = var.domain
  memory                = var.memory
  vcpus                 = var.vcpus
  libvirt_pool          = var.libvirt_pool
  base_image            = var.base_image
  image_repo            = var.image_repo
  disk_size             = var.disk_size
  data_disk		= false
  multiple_network	= false
}

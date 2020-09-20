// Define the base_volume
resource "libvirt_volume" "base_vol" {
  name 		= "${var.hostname}_base_vol"
  pool 		= var.libvirt_pool
  source	= "${var.image_repo}/${var.base_image}"
}

// Create the disk for the VM
resource "libvirt_volume" "os_volume" {
  name 		 = "${var.hostname}.${var.domain}.qcow2"
  pool		 = var.libvirt_pool
  base_volume_id = libvirt_volume.base_vol.id
// Variable size multiplied by 1GB in bytes
  size 		 = var.disk_size
}

// Create additional disk for pulp, mongodb and pgsql
resource "libvirt_volume" "data_disk1" {

  name		= "${var.hostname}.${var.domain}-data.qcow2"
  pool		= var.libvirt_pool
  size		= var.data_disk1_size
}

// Create cloud-init image
resource "libvirt_cloudinit_disk" "satellite_common_init" {
  name 		= "satellite_common_init.iso"
  pool 		= "images"
}

data "template_file" "user_data" {
  template	= "${file("${path.module}/cloud_init.cfg")}"
}

// Create the virtual machine
resource "libvirt_domain" "vm" {
  name 		= "${var.hostname}.${var.domain}"
  memory	= var.memory
  vcpu		= var.vcpus
  
  cloudinit 	= libvirt_cloudinit_disk.satellite_common_init.id

  disk { 
    volume_id 	= libvirt_volume.os_volume.id 
  }
  disk { 
    volume_id 	= libvirt_volume.data_disk1.id 
  }

  network_interface {
    bridge	= "${lookup(var.networks, "public")}"
  }
  network_interface { 
    bridge	= "${lookup(var.networks, "vmnet")}"
  }

  console {
    type 	= "pty"
    target_type	= "serial"
    target_port	= "0"
  }

  console {
    type	= "pty"
    target_type	= "virtio"
    target_port = "1"
  }
}

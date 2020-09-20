provider "vsphere" {
  user       = var.vsphere_user
  password   = var.vsphere_password
  vsphere_server = var.vsphere_server

allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
    name = "fudgepops"
}
 
data "vsphere_datastore" "datastore" {
    name = "nas_iscsi"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_compute_cluster" "cluster" {
    name = "clusterfudge"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
    name    = "vm_network"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
    name = "rh8_efi_template"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "vm" {
    name    = var.vsphere_vm_name
    count   = var.vm_count
    folder  = var.vm_folder
    resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
    datastore_id = data.vsphere_datastore.datastore.id
    num_cpus = var.vm_cpu
    memory = var.vm_ram
    guest_id = data.vsphere_virtual_machine.template.guest_id
    scsi_type = data.vsphere_virtual_machine.template.scsi_type
    firmware = data.vsphere_virtual_machine.template.firmware
    efi_secure_boot_enabled = true

    network_interface {
        network_id = data.vsphere_network.network.id
        adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
    }

    disk {
        label = "disk0"
        size = data.vsphere_virtual_machine.template.disks.0.size
        thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
    }

    clone {
        template_uuid = data.vsphere_virtual_machine.template.id
        customize {
            timeout = 0

            linux_options {
                host_name = var.vsphere_vm_name
                domain = var.vsphere_vm_domain
            }
            network_interface {}
        }
    }
}

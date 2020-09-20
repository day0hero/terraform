resource "vsphere_virtual_machine" "vm" {
    count   = var.vm_count
    name    = "${var.hostname}-${count.index}"
    folder  = var.vsphere_vm_folder
    resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
    datastore_id = data.vsphere_datastore.datastore.id
    num_cpus = var.vm_cpu
    memory = var.vm_ram
    guest_id = data.vsphere_virtual_machine.template.guest_id
    scsi_type = data.vsphere_virtual_machine.template.scsi_type
    firmware  = data.vsphere_virtual_machine.template.firmware
    efi_secure_boot_enabled = true

    network_interface {
        network_id = "${data.vsphere_network.network.id}"
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
                host_name = "${var.hostname}-${count.index}"
                domain = var.domain
            }
            network_interface {}
        }
    }
}

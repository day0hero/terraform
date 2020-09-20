output "vm_mac" {
    value = vsphere_virtual_machine.vm.*.network_interface.0.mac_address
}

output "vm_ip" {
    value = vsphere_virtual_machine.vm.*.default_ip_address
}

variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}
variable "vsphere_compute_cluster" {}
variable "vsphere_datacenter" {}
variable "vsphere_datastore" {}
variable "vsphere_vm_folder" {
    default = "vms"
}

variable "hostname" {
    type = string
}

variable "vm_count" {}
variable "domain" {}
variable "vm_cpu" {
    default = 2
}
variable "vm_ram" {
    default = 2048
}
variable "templates" {
    type = map
    default = {
        "rh7" = "rh7_template"
        "rh8" = "rh8_efi_template"
        "ubuntu20" = "ubuntu20_template"
        "w2k16" = "2k16_template"
        "w2k19" = "2k19_template"
    }
}
variable "vm_template" {
    default = "rh8"
}
variable "networks" {
    type = map
    default = {
      "public" = "vmPublic"
      "vmNet"  = "vmNetwork"
     }
 }
variable "vm_net" {
    default = "vmNet"
}


#OpenShift Stuff
variable "ocp_clustername" {
  default = "ocp4"
}


## Red Hat Satellite terraform module
This module is used to provision a Virtual Machine that will ultimately be used
for Red Hat Satellite. 

Red Hat recommends having the Satellite data content (pulp, pgsql and mongodb on 
a separate disk/LVM so this template provisions with two disks. If you want to add
additional disks increase the index on the disk. NOTE: You will need to modify variables.tf 
and main.tf to accomodate the change.

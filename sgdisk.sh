# format /dev/sda as GPT, GUID Partition Table
sgdisk - Z /dev/sda

sgdisk -n 0:0:+200M -t 0:ef02 -c 0:"bios_boot" /dev/sda
sgdisk -n 0:0:+20G -t 0:8300 -c 0:"linux_boot" /dev/sda
sgdisk -n 0:0:+10G -t 0:8200 -c 0:"linux_swap" /dev/sda
sgdisk -n 0:0:0 -t 0:8300 -c 0:"os_data" /dev/sda

sgdisk -p /dev/sda

# inform the OS of partition changes
partprobe /dev/sda
fdisk -l /dev/sda

# mount & mkdir

mkdir /mnt/bios_boot
mkdir /mnt/linux_boot
mkdir /mnt/linux_swap
mkdir /mnt/os_data

mount LABEL=bios_boot /mnt/bios_boot
mount LABEL=linux_boot /mnt/linux_boot
mount LABEL=linux_swap /mnt/linux_swap
mount LABEL=os_data /mnt/os_data

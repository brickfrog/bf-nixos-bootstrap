# format /dev/sda as GPT, GUID Partition Table
sgdisk - Z /dev/sda

sgdisk -n 0:0:+200M -t 0:ef00 -c 0:"boot" /dev/sda
sgdisk -n 0:0:+10G -t 0:8200 -c 0:"swap" /dev/sda
sgdisk -n 0:0:0 -t 0:8300 -c 0:"data" /dev/sda

sgdisk -p /dev/sda

# inform the OS of partition changes
partprobe /dev/sda

mkfs.vfat -n "BOOT" /dev/sda1
mkswap /dev/sda2 --label "SWAP"
mkfs.ext4 -n "DATA" /dev/sda3

fdisk -l /dev/sda

# mount & mkdir

mkdir /mnt/boot
mkdir /mnt/swap
mkdir /mnt/os_data

mount LABEL=DATA /mnt
mount LABEL=BOOT /mnt/boot
mount LABEL=SWAP /mnt/swap

swapon /dev/sda2

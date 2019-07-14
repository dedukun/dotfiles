#!/bin/bash
second_dev="/dev/second/debian_gbt"
second_mount_point="$HOME/Globaltronic/Second_GBT"
second_mount=false
second_umount=false

print_help () {
    printf "Change Second Driver.\n"
    printf "This script helps configuring the second mass storage driver.\n"
    printf "\t-m, --mount       Mount the second driver.\n"
    printf "\t-u, --umount      Un-mount the second driver.\n"
    printf "\t    --mount-point Define the mount point.     [default: '%s']\n"  "\$HOME/Globaltronic/Second_GBT"
    printf "\t-d, --dev         Define the device.          [default: '%s']\n" "$second_dev"
    printf "\t-h, --help        Prints help menu.\n"
}

mount_second() {
    sudo mount "$second_dev" "$second_mount_point"
    sync
}

umount_second() {
    sudo umount "$second_mount_point"
    sync
}

while [[ $# -gt 0 ]]
do
    csd_key="$1"

    case "$csd_key" in
        -m|--mount)
        second_mount=true
        shift # past argument
        ;;
        -u|--umount)
        second_umount=true
        shift # past argument
        ;;
        --mount-point)
        second_mount_point="$2"
        shift # past argument
        shift # past value
        ;;
        -d|--dev)
        second_dev="$2"
        shift # past argument
        shift # past value
        ;;
        -h|--help)
        shift # past argument
        print_help
        exit
        ;;
        *)
        echo "Invalid argument '$1'."
        echo "For more help use argument -h or --help".
        shift # past argument
        exit 1
        ;;
    esac
done

if [ "$second_mount" = true ]; then
    mount_second
elif [ "$second_umount" = true ]; then
    umount_second
else
    print_help
fi

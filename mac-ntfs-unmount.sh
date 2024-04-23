#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "You should run this script as root."
    exit
fi

diskutil list

umount /dev/disk
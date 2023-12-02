#!/bin/bash

function fixbootloader {

    echo "fix bootloader"
    os-prober 
    grub-mkconfig -o /boot/grub/grub.cfg
    echo ""
    reboot
}

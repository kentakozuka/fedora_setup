#!/bin/sh

# findmntでusbのパスを確認

usb_path = "/run/media/kenta/kenta_usb"
iso_path = "~/Download/Fedora-Workstation-Live-x86_64-26-1.5.iso"

sgdisk --zap-all $usb_path

dd if=$iso_path of=$usb_path bs=blocksize


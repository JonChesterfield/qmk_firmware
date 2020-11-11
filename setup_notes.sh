#!/bin/bash

id=`id -u`

if [ $id = "0" ]
then

    echo "Root setup"
    apt-get install python3 python3-pip gcc unzip wget zip gcc-avr binutils-avr avr-libc dfu-programmer dfu-util gcc-arm-none-eabi binutils-arm-none-eabi avrdude libusb-dev

    cat << EOF >> /etc/udev/rules.d/50-wally.rules
# Teensy rules for the Ergodox EZ
ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"
EOF

    cat << EOF >> /etc/udev/rules.d/50-oryx.rules
# Rule for all ZSA keyboards
SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
# Rule for the Ergodox EZ
SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
EOF

    
else

    python3 -m pip install --user qmk

    export PATH=$PATH:~/.local/bin
    qmk setup
    
    wget https://github.com/zsa/wally-cli/releases/download/2.0.0-linux/wally-cli -O ~/.local/bin/wally-cli
    chmod +x ~/.local/bin/wally-cli
fi


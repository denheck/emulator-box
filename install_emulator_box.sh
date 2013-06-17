#!/bin/bash

function print_msg()
{
    echo -e "$1..."
}

# check if package is installed via apt-get
function apt_package_query()
{
    print_msg "checking for package: $1"
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $1|grep "install ok installed")
    if [ "" == "$PKG_OK" ]; then
        return 0
    else
        return 1
    fi
}

# install package via apt-get
function apt_package_install()
{
    PKG=$1
    
    apt_package_query $PKG
    if [ $? == 1 ]; then
        print_msg "package '$PKG' already installed"
    else
        print_msg "installing: '$PKG'"
        sudo apt-get -y install $PKG
    fi
}

# update APT repositories
function apt_update() 
{
    print_msg "updating apt-get database"
    sudo apt-get -y update
}

# upgrade APT packages
function apt_upgrade()
{
    print_msg "performing apt-get upgrade"
    sudo apt-get -y upgrade
}

# install ps3 controller drivers
function install_ps3_controller()
{
    # install usb controller support
    print_msg "Installing Playstation 3 controller drivers"
    apt_package_install libusb-dev
    apt_package_install joystick
    apt_package_install libusb-0.1-4
    # apt_package_install xserver-xorg-input-joystick ## not sure if needed

    # install bluetooth support
    apt_package_install pyqt4-dev-tools
    apt_package_install pkg-config
    apt_package_install libjack-dev
    apt_package_install bluez-utils
    apt_package_install bluez-compat
    apt_package_install bluez-hcidump
    apt_package_install checkinstall
    apt_package_install libbluetooth-dev

    sudo rm -rf /tmp/emulator/sixad
    sudo mkdir -p /tmp/emulator/sixad/ -m 777
    git clone git://github.com/aaronp24/QtSixA.git /tmp/emulator/sixad/
    cd /tmp/emulator/sixad/
    make
    sudo make install
}

function main()
{
    # package manager updates
    #apt_update
    #apt_upgrade

    # install dependencies
    apt_package_install git
    apt_package_install zsnes

    install_ps3_controller
}

main

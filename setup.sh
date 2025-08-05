#!/bin/bash
# build the image out of the Docker file
podman build docker -t flutter
# initialize the container and open an port for ssh
podman run -d -i --privileged -v /dev/bus/usb:/dev/bus/usb --name FlutterDevContainer --replace -v ~/flutter:/flutter:z -p [::1]:20202:22 flutterdev

#make the container reachable with ssh
## set a temporary Password to log in from ssh and launch ssh
echo "please set the root password for the container"
read pw
echo "you put in$pw"
podman exec FlutterDevContainer bash -c "echo 'root:$pw' | chpasswd"
podman exec FlutterDevContainer /usr/sbin/sshd

# change from password authentication to ssh key
## generate one
ssh-keygen -t ed25519
## copy it into the container the Password will be needed
ssh-copy-id -i ~/.ssh/id_ed25519.pub -p 20202 root@::1

##Preconfigure ssh
echo "Host FlutterDevContaier" >> $HOME/.ssh/config
echo "    HostName ::1" >> $HOME/.ssh/config
echo "    User root" >> $HOME/.ssh/config
echo "    Port 20202" >> $HOME/.ssh/config

## install vsc ssh extension 
flatpak run com.vscodium.codium --install-extension 3timeslazy.vscodium-devpodcontainers
#!/bin/bash
# build the image out of the Docker file
podman build docker --build-arg DISPLAY=$DISPLAY -t flutter
# initialize the container and open an port for ssh
mkdir ~/flutter
podman run -d --privileged \
  -v /dev/bus/usb/:/dev/bus/usb -v /etc/udev/rules.d/:/etc/udev/rules.d \
  -v /etc/localtime:/etc/localtime:ro \
  -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY --security-opt label=disable \
  -v ~/flutter:/flutter:z \
  --net=host \
  --replace \
  --name FlutterDevContainer -ti localhost/flutter
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
echo "Host FlutterDevContaier" >>$HOME/.ssh/config
echo "    HostName ::1" >>$HOME/.ssh/config
echo "    User root" >>$HOME/.ssh/config
echo "    Port 20202" >>$HOME/.ssh/config

## install vsc ssh extension
flatpak install com.vscodium.codium
flatpak run com.vscodium.codium --install-extension 3timeslazy.vscodium-devpodcontainers

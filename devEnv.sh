#!/bin/bash
xhost +"local:podman@"
startOutput=$(podman start FlutterDevContainer)
echo $startOutput
if [ "$startOutput" == "FlutterDevContainer" ]; then
  podman exec FlutterDevContainer /usr/sbin/sshd && flatpak run com.vscodium.codium
else
  echo "starting installer" && ./setup.sh
fi

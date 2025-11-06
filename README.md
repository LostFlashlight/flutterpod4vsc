# FlutterPod4VSCodium
a little script to get the funktionality of a flutter dev container one the opensource forkes of Visual-Studio-Code
the script will preinstall vscodium but the setup should work with oss-code as well. 
## features:
- onecommand installer
- developing for a physical android device

## planed:
- [ ] linux development
- [ ] web dev
## installation
clone the repo
```
git clone https://github.com/LostFlashlight/flutterpod4vsc.git
```
Then just run the devEnv script and you should be good to go

```
chmod -R +x flutterpod4vsc
cd flutterpod4vsc
./devEnv.sh
```
usage:
run the env script if you are already set up it will only starte the pod and open vsc
```
./devEnv.sh
```
Then go to the Remote Explorer on your sidebar and rightckick on the FlutterDevContaier.
After klicking on Connect to Host in Current Window you schould be good to go and able to start developing.
## inspiration:
https://howtos.davidsebek.com/vscodium-containers.html

https://blog.devops.dev/developing-flutter-applications-inside-a-devcontainer-4b13de5369e2

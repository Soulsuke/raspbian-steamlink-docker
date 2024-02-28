# raspbian-steamlink-docker

Apparently steamlink only runs on armhf, up to Raspbian Buster.  
This is an attempt to make it work on modern aarm64 distros.  

**NOTE:** I'm a docker newbie, and I know enough of it to be dangerous. What
works for me may not work for everyone.  



### Docker notes (Arch)  

May as well keep these here.  

##### Qemu setup (to work on x86 hosts)  

Install qemu: `pacman -S qemu-base qemu-user-static qemu-user-static-binfmt`  

##### Docker setup  

Install docker: `pacman -S docker docker-buildx`  
Enable services: `systemctl enable --now docker.socket`  

Build the image: `docker build --no-cache -t steamlink docker/`  

Add user to `docker` group, so it can actually do something.  

List images: `docker image ls`  
Delete built image: `docker image rm steamlink`  



### TODO

* replace --privileged with only the needed devices (eg. --device=/dev/vchiq)  
* do we need to use --detach ?  
* do we need to install xterm to show popups?  
* do we need sudo privileges?  



### NOTES: building time depending on the FROM image

* arm32v7/debian:buster => 1717.2s  
* resin/rpi-raspbian:buster => 842.1s

So, if possible, let's stick with the second one.  



### NOTES: tests on x68_64

* resin/rpi-raspbian:buster:  
  * not sudoer, no xterm: `home/steamlink/.local/share/SteamLink/steamlink.sh: line 198:   142 Illegal instruction     (core dumped) LD_PRELOAD=$QT_QPA_EGLFS_PRELOAD shell "$@"`  
  * not sudoer, xterm: `/home/steamlink/.local/share/SteamLink/steamlink.sh: line 198:    69 Illegal instruction     (core dumped) LD_PRELOAD=$QT_QPA_EGLFS_PRELOAD shell "$@"`  
  * sudoer, no xterm: `/home/steamlink/.local/share/SteamLink/steamlink.sh: line 198:    69 Illegal instruction     (core dumped) LD_PRELOAD=$QT_QPA_EGLFS_PRELOAD shell "$@"`  
  * sudoer, xterm: `/home/steamlink/.local/share/SteamLink/steamlink.sh: line 198:   142 Illegal instruction     (core dumped) LD_PRELOAD=$QT_QPA_EGLFS_PRELOAD shell "$@"`  
* arm32v7/debian:buster:  
  * not sudoer, no xterm: `/home/steamlink/.local/share/SteamLink/steamlink.sh: line 198:    69 Aborted                 (core dumped) LD_PRELOAD=$QT_QPA_EGLFS_PRELOAD shell "$@"`  
  * not sudoer, xterm: ``  
  * sudoer, no xterm: ``  
  * sudoer, xterm: ``  

I really need to test it on archarm.  


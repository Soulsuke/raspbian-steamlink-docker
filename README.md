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

Add user to docker group.  

List images: `docker image ls`  
Delete built image: `docker image rm steamlink`  


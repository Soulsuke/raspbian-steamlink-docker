# raspbian-steamlink-docker  

Apparently steamlink only runs on armhf, up to Raspbian Buster.  
This is an attempt to make it work on modern aarm64 distros.  

**NOTE:** I'm a docker newbie, and I know enough of it to be dangerous.  

Ideally, the `docker` folder contains all the needed files to build the image
via `docker build --no-cache --platform=linux/arm/v7 -t steamlink docker/`,
and the `start.bash` script takes care of running steamlink from the
container setting up everything that's needed.  



### Acknowledgements

The pulseaudio config for docker has been taken from here:  
`https://github.com/TheBiggerGuy/docker-pulseaudio-example/tree/master`  



### What works  

* steamlink correctly starts up  
* steamlink can pair with a Steam client on the network  
* all relevant data folders are correctly mounted as volumes, so persistency
  works  
* ideally pulseaudio settings are there  



### And what does not  

* alsa can't find the sound card  
* streaming does not work: `* failed to open vchiq instance`  



### Docker notes  

Add user to `docker` group, so it can actually start stuff.  

Build the image: `docker build --no-cache --platform=linux/arm/v7 -t steamlink docker/`  

List images: `docker image ls`  

Delete built image: `docker image rm -f steamlink`  


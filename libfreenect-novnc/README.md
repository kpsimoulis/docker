[![](https://badge.imagelayers.io/psharkey/novnc:latest.svg)](https://imagelayers.io/?images=psharkey/novnc:latest 'Get your own badge on imagelayers.io')
# Alpine X11 Display Container
```
```
This image is intended to be used for displaying X11 applications from other containers in a browser. A stand-alone demo as well as a [Version 2](https://docs.docker.com/compose/compose-file/#version-2) composition. Thanks to [Alpine](https://hub.docker.com/_/alpine/), this image is < 100Mb and eliminates the need to run an X11 server on your host machine.
## Image Contents
___
* [Xvfb](http://www.x.org/releases/X11R7.6/doc/man/man1/Xvfb.1.xhtml) - X11 in a virtual framebuffer
* [x11vnc](http://www.karlrunge.com/x11vnc/) - A VNC server that scrapes the above X11 server
* [noNVC](https://kanaka.github.io/noVNC/) - A HTML5 canvas vnc viewer
* [Fluxbox](http://www.fluxbox.org/) - a small window manager
* [socat](http://www.dest-unreach.org/socat/) - for use with other containers
* [xterm](http://invisible-island.net/xterm/) - to demo that it works
* [supervisord](http://supervisord.org) - to keep it all running
## Usage
___
### Stand-alone Demo
*On Windows and OS X Only -*
Determine the Docker machine IP address:
```bash
$ docker-machine ip $(docker-machine active)
192.168.99.101
```
Run: 
```bash
$ docker run --rm -it -p 8080:8080 psharkey/novnc
```
Open a browser and hit the *Connect* button to see the `xterm` demo at `http://<DOCKER_MACHINE_IP>:8080/vnc.html`
### V2 Composition
A version of the [V2 docker-compose example](https://github.com/psharkey/docker/blob/master/novnc/docker-compose.yml) is shown below to illustrate how this image can be used to greatly simplify the use of X11 applications in other containers. With just `docker-compose up -d`, your favorite IDE can be accessed via a browser.

Some notable features:
* An `x11` network is defined to link the IDE and novnc containers
* The IDE `DISPLAY` environment variable is set using the novnc container name
* The screen size is adjustable to suit your preferences via environment variables
* The only exposed port is for HTTP browser connections

```
version: '2'
services:
  ide:
    image: psharkey/intellij:latest
#    image: psharkey/netbeans-8.1:latest
    environment:
      - DISPLAY=novnc:0.0
    depends_on:
      - novnc
    networks:
      - x11
  novnc:  
    image: psharkey/novnc:latest
    environment:
      # Adjust to your screen size
      - DISPLAY_WIDTH=1600
      - DISPLAY_HEIGHT=968
    ports:
      - "8080:8080"
    networks:
      - x11
networks:
  x11:
```
**If the IDE fails to start simply run `docker-compose restart <container-name>`.** 
## On DockerHub / GitHub
___
* DockerHub [psharkey/novnc](https://hub.docker.com/r/psharkey/novnc/)
* GitHub [psharkey/docker/novnc](https://github.com/psharkey/docker/tree/master/novnc)

# Thanks
___
Based on [wine-x11-novnc-docker](https://github.com/solarkennedy/wine-x11-novnc-docker) and [octave-x11-novnc-docker](https://hub.docker.com/r/epflsti/octave-x11-novnc-docker/).

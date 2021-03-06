libfreenect-novnc
=================

Docker image to provide HTML5 VNC interface to access libfreenect environment

Requirements
------------

You need to download a fakenect recorded session extract it local directory "./session"

Quick Start
-------------------------

Run the docker image and open ports `6080` and `5900`

```
docker-compose up
```

Browse http://127.0.0.1:6080/ and inside the terminal type

```
freenect-glview
```

In your web browser you should see the freenect application:

![Explorer Screenshot](https://raw.githubusercontent.com/kpsimoulis/docker/master/libfreenect-novnc/screenshot.png)

Connect with VNC Viewer and protect by VNC Password
------------------

Open the vnc viewer and connect to port 5900

If you would like to protect vnc service by password, set environment variable `VNC_PASSWORD`, for example

```
VNC_PASSWORD=docker docker-compose up
```

A prompt will ask password either in the browser or vnc viewer.
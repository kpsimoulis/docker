FROM openjdk:8-jdk-alpine3.7

# Setup demo environment variables
ENV HOME=/root \
	DEBIAN_FRONTEND=noninteractive \
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8 \
	LC_ALL=C.UTF-8 \
	DISPLAY=:0.0 \
	DISPLAY_WIDTH=1024 \
	DISPLAY_HEIGHT=768 \
	LD_PRELOAD=/usr/local/lib/fakenect/libfakenect.so \
	FAKENECT_PATH=/session

# x11vnc is in testing repo
RUN echo "http://dl-3.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# Install git, supervisor, VNC, & X11 packages
RUN apk --update --upgrade add \
	bash \
	fluxbox \
	git \
	socat \
	supervisor \
	x11vnc \
	xterm \
	xvfb \
	freeglut \
	libusb \
	mesa-dri-swrast \
	maven

ENV DEPS \
		libusb-dev \
		g++ \
		gcc \
		make \
		cmake \
		freeglut-dev \
		git

RUN apk add --no-cache --virtual .build-deps $DEPS && \
    git clone https://github.com/OpenKinect/libfreenect.git /opt/libfreenect && \
    cd /opt/libfreenect && \
    git checkout 5ac29879b9c5de3cda9a63bb2dd3c8883ab75e39 && \
    mkdir build && \
    cd build && \
    cmake -L .. && \
    make && \
    make install && \
    git clone https://github.com/kanaka/noVNC.git /root/noVNC && \
    cd /root/noVNC && \
    git checkout 6a90803feb124791960e3962e328aa3cfb729aeb && \
    ln -s vnc_auto.html index.html && \
    git clone https://github.com/kanaka/websockify /root/noVNC/utils/websockify && \
    rm -rf /root/noVNC/.git && \
    rm -rf /root/noVNC/utils/websockify/.git && \
    apk del .build-deps && \
    cd && \
    rm -fr /opt/libfreenect

# Modify the launch script 'ps -p'
RUN sed -i -- "s/ps -p/ps -o pid | grep/g" /root/noVNC/utils/launch.sh

COPY etc/supervisor /etc/supervisor

COPY docker-entrypoint.sh /

EXPOSE 6080 5900

ENTRYPOINT ["/docker-entrypoint.sh"]
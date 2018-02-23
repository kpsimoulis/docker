FROM kpsimoulis/xclock

RUN apk --update --upgrade add \
	freeglut \
	libusb \
	mesa-dri-swrast

ENV DEPS \
		libusb-dev \
		g++ \
		gcc \
		make \
		cmake \
		freeglut-dev \
		mesa-dri-swrast \
		git

RUN apk add --no-cache --virtual .build-deps $DEPS && \
    git clone https://github.com/OpenKinect/libfreenect.git && \
    cd libfreenect && \
    git checkout 5ac29879b9c5de3cda9a63bb2dd3c8883ab75e39 && \
    mkdir build && \
    cd build && \
    cmake -L .. && \
    make && \
    make install && \
    apk del .build-deps && \
    cd && \
    rm -fr /libfreenect

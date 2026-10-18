FROM debian:trixie-slim
ENV DEBIAN_FRONTEND noninteractive

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y update && apt-get -y install \
	bc \
	build-essential \
	bzip2 \
	bzr \
	ca-certificates \
	cmake \
	cmake-curses-gui \
	cpio \
	curl \
	device-tree-compiler \
	dosfstools \
	e2fsprogs \
	fdisk \
	gawk \
	gdisk \
	git \
	golang \
	libncurses5-dev \
	libsdl2-dev \
	libsdl2-image-dev \
	libsdl2-ttf-dev \
	locales \
	make \
	rsync \
	scons \
	squashfs-tools \
	sshpass \
	tree \
	u-boot-tools \
	udev \
	unzip \
	wget \
	zip \
  && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/Evsio0n/rsce-go && cd rsce-go \
 && go mod download && go mod tidy && go build -ldflags="-s -w" -o rsce_tool \
 && cp rsce_tool /usr/local/bin/ && cd ../ \
 && rm -rf rsce-go

RUN mkdir -p /root/workspace
WORKDIR /root

VOLUME /root/workspace
WORKDIR /root/workspace

ENV CROSS_COMPILE=/usr/bin/aarch64-linux-gnu-
ENV PREFIX=/usr

CMD ["/bin/bash"]

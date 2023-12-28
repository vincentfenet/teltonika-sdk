FROM ubuntu:18.04
LABEL org.opencontainers.image.authors="vincent.fenet@gmail.com"
RUN apt update && apt install -y build-essential ccache ecj fastjar file flex g++ gawk gettext git java-propose-classpath java-wrappers jq libelf-dev libffi-dev libncurses5-dev libncursesw5-dev libssl-dev libtool python python2.7-dev python3 python3-dev python3-distutils python3-setuptools rsync subversion swig time u-boot-tools unzip wget xsltproc zlib1g-dev bison curl sudo
RUN wget -O - https://deb.nodesource.com/setup_14.x | bash - && apt update && apt install -y nodejs
RUN useradd -m builder && echo 'builder ALL=NOPASSWD: ALL' > /etc/sudoers.d/builder
USER builder
WORKDIR /home/builder
RUN wget -O - https://firmware.teltonika-networks.com/7.6/RUTX/RUTX_R_GPL_00.07.06.tar.gz -q | tar xzf - -C .
RUN cd rutos-ipq40xx-rutx-gpl; ./scripts/feeds update -a
RUN sed -i "s#PKG_SOURCE_URL=git://git.osmocom.org/libsmpp34.git#PKG_SOURCE_URL=https://git.osmocom.org/libsmpp34#" ~/rutos-ipq40xx-rutx-gpl/package/libs/libsmpp34/Makefile
RUN cd rutos-ipq40xx-rutx-gpl; make -j8

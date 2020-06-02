FROM ubuntu:18.04

RUN sed -i 's/http:\/\/archive\.ubuntu\.com\/ubuntu\//http:\/\/mirrors\.163\.com\/ubuntu\//g' /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get install -y make wget cmake git autoconf automake libtool file
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
RUN mkdir /build && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone
RUN apt-get install -y android-tools-adb
RUN apt-get install -y unzip
RUN echo no | dpkg-reconfigure dash
RUN wget -c https://dl.google.com/android/repository/android-ndk-r20-linux-x86_64.zip?hl=zh-cn -O /build/android-ndk-r20-linux-x86_64.zip
RUN unzip /build/android-ndk-r20-linux-x86_64.zip -d /opt/
RUN rm /build/android-ndk-r20-linux-x86_64.zip
RUN apt-get install -y python
RUN /opt/android-ndk-r20/build/tools/make_standalone_toolchain.py --arch arm64 --api 24 --stl=libc++ --install-dir /opt/android-toolchain
RUN apt install -y vim strace cmake lrzsz python3 python3-pip
RUN apt install -y tmux gawk
RUN apt install -y gdb
WORKDIR /build
RUN apt update
RUN apt install -y zip
RUN pip3 install frida-tools
RUN apt install -y openjdk-8-jdk
RUN pip3 install beautifulsoup4 lxml
RUN wget -c https://dl.google.com/android/repository/build-tools_r27.0.3-linux.zip -O /build/build-tools-27.0.3.zip
RUN unzip /build/build-tools-27.0.3.zip -d /opt/
ENV PATH /opt/android-8.1.0:$PATH
COPY entrypoint.sh /entrypoint.sh 
# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

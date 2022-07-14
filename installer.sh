#!/bin/bash

ARCH32=arm-linux-gnueabihf
MESAFALGS="-Dgallium-drivers=freedreno -Dvulkan-drivers=freedreno"
MESA=0
MULTIARCH=0
STEAM=0
tmp_dir=$(mktemp -d -t dev-XXXXXXXXXX)  
sudo apt update && sudo apt upgrade -y && sudo apt install dialog
if dialog --yesno "Do you want to compile and install mainline Freedreno and Turnip?" 0 0; 
  then
  MESA=1
fi

if dialog --yesno "Do you want to set up multiarch and Box86 instead just Box64?" 0 0;
  then
  MULTIARCH=1
fi
if [[ "$MULTIARCH" == 1 ]];
  then 
    if dialog --yesno "Do you want to install manually Steam i386 deb in /usr/ directory? Dependencies are not included as they are changing so you still will need to install them manually." 0 0;
    then 
	STEAM=1
  fi
fi

if ! grep "deb-src http://deb.debian.org/debian/ bookworm main non-free" /etc/apt/sources.list;
  then 
  sudo sh -c 'echo "deb-src http://deb.debian.org/debian/ bookworm main non-free" >> /etc/apt/sources.list'
fi
sudo apt update && sudo apt upgrade -y && sudo apt build-dep mesa -y && sudo apt install cmake git wget -y

if [[ "$MULTIARCH" == 1 ]];
  then 
  sudo dpkg --add-architecture armhf && sudo apt update -y && sudo apt install g++-$ARCH32 zlib1g-dev:armhf libexpat1-dev:armhf libdrm-dev:armhf libx11-dev:armhf libxext-dev:armhf libxdamage-dev:armhf libxcb-glx0-dev:armhf libx11-xcb-dev:armhf libxcb-dri2-0-dev:armhf libxcb-dri3-dev:armhf libxcb-present-dev:armhf libxshmfence-dev:armhf libxxf86vm-dev:armhf libxrandr-dev:armhf libwayland-dev:armhf wayland-protocols:armhf libwayland-egl-backend-dev:armhf libxcb-shm0-dev:armhf -y
fi

cd $tmp_dir

if [[ "$MESA" == 1 ]];
  then
  git clone https://gitlab.freedesktop.org/mesa/mesa && cd mesa && meson build64 $MESAFALGS && ninja -C build64/ && sudo ninja -C build64/ install
fi

if [[ "$MESA" == 1 ]] && [[ "$MULTIARCH" == 1 ]];
  then
  echo -e "[binaries]\nc = '$ARCH32-gcc'\ncpp = '$ARCH32-g++'\nar = '$ARCH32-ar'\nstrip = '$ARCH32-strip'\npkgconfig = '$ARCH32-pkg-config'\n\n[host_machine]\nsystem = 'linux'\ncpu_family = 'arm'\ncpu = 'armv8.2l'\nendian = 'little'" > cross.txt && meson build32 --cross-file=cross.txt --libdir=lib/$ARCH32 $MESAFALGS && ninja -C build32/ && sudo ninja -C build32/ install
fi

cd $tmp_dir
git clone https://github.com/ptitSeb/box64 && cd box64 && mkdir build && cd build && cmake .. -DSD845=1 && make -j8 && sudo make install && cd $tmp_dir

if [[ "$MULTIARCH" == 1 ]];
  then
  git clone https://github.com/ptitSeb/box86 && cd box86 && mkdir build && cd build && cmake .. -DSD845=1 && make -j8 && sudo make install && cd $tmp_dir
fi 

sudo systemctl restart systemd-binfmt

if [[ "$MULTIARCH" == 1 ]] && [[ "$STEAM" == 1 ]];
  then
  mkdir steam; cd steam; wget http://media.steampowered.com/client/installer/steam.deb; ar x steam.deb; tar xf data.tar.xz
  sudo cp -R ./usr/* /usr/
fi

cd ~/ && sudo rm -R $tmp_dir

# PREREQUISITES

At the beginning we need to add multiarch and compile up to date Mesa in armhf and aarch64 versions as Turnip and Freedreno works often much better in newer versions.

Add surce repository to your /etc/apt/sources.list in my case it's `deb-src http://deb.debian.org/debian/ bookworm main non-free` and armhf architecture to dpkg with `sudo dpkg --add-architecture armhf`

Now we need to install mesa dependencies for both architectures, git and cmake for box'es 

```
sudo apt update && sudo apt upgrade && sudo apt build-dep mesa && sudo apt install cmake git wget g++-arm-linux-gnueabihf zlib1g-dev:armhf libexpat1-dev:armhf libdrm-dev:armhf libx11-dev:armhf libxext-dev:armhf libxdamage-dev:armhf libxcb-glx0-dev:armhf libx11-xcb-dev:armhf libxcb-dri2-0-dev:armhf libxcb-dri3-dev:armhf libxcb-present-dev:armhf libxshmfence-dev:armhf libxxf86vm-dev:armhf libxrandr-dev:armhf libwayland-dev:armhf wayland-protocols:armhf libwayland-egl-backend-dev:armhf libxcb-shm0-dev:armhf
```

Time to get mesa source code `git clone https://gitlab.freedesktop.org/mesa/mesa` and inside git directory create config file with settings for cross compilation containing code below i used file name `cross.txt` in Mesa compilation command and advice to do the same or change it in next step.

```
[binaries]
c = 'arm-linux-gnueabihf-gcc'
cpp = 'arm-linux-gnueabihf-g++'
ar = 'arm-linux-gnueabihf-ar'
strip = 'arm-linux-gnueabihf-strip'
pkgconfig = 'arm-linux-gnueabihf-pkg-config'

[host_machine]
system = 'linux'
cpu_family = 'arm'
cpu = 'armv8.2l'
endian = 'little'
```

And time to compile driver. My meson config is verry basic, if you know how to improve it, open issue. 

```
meson build64 -Dgallium-drivers=freedreno -Dvulkan-drivers=freedreno && ninja -C build64/ && sudo ninja -C build64/ install && meson build32 --cross-file=cross.txt --libdir=lib/arm-linux-gnueabihf -Dgallium-drivers=freedreno -Dvulkan-drivers=freedreno && ninja -C build32/ && sudo ninja -C build32/ install 
``` 

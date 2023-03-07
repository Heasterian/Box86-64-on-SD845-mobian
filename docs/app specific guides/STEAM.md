# STEAM

Installing steam is straight forward as mostly you need to download deb file from Valve server, extract it and run binary. Probably some libs will be missing, command below should install most of them.

```
sudo apt install libc6:armhf libncurses5:armhf libsdl2-2.0-0:armhf libsdl2-image-2.0-0:armhf libsdl2-mixer-2.0-0:armhf libsdl2-ttf-2.0-0:armhf libopenal1:armhf libpng16-16:armhf libfontconfig1:armhf libxcomposite1:armhf libbz2-1.0:armhf libxtst6:armhf
```

At this moment big picture will use most of devices RAM so it will freeze without swap after a while.

For just installing Steam use can use this command: 

```
cd ~; mkdir steam; cd steam; wget http://media.steampowered.com/client/installer/steam.deb; ar x steam.deb; tar xf data.tar.xz; STEAMOS=1 DBUS_FATAL_WARNINGS=0 ./usr/lib/steam/bin_steam.sh
```

And than run it with command below:

```
STEAMOS=1 DBUS_FATAL_WARNINGS=0 ~/steam/usr/lib/steam/bin_steam.sh
```

If you want to reduce RAM usage, disable steamwebhelper in /etc/box64.box64rc file, it will break some things, but small mode will work.

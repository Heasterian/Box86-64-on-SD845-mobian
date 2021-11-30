# WINE AND PROTON

Compatibility of ceratin versions are changing all the time. At moment of writting this guide last staging version that work for me is 5.9. Stable works fine from last build.

Precompiled binaries of pure Wine you can download from PlayOnLinux automated builds: https://www.playonlinux.com/wine/binaries/phoenicis/
Proton build, you can find here. Compatibility of versions in my testing matches that of Wine staging: https://github.com/GloriousEggroll/proton-ge-custom/releases

Good option is to extract it and link binaries to /usr/local/bin/

To download and install winetricks you can use this command:

```
cd ~/Downloads
wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && sudo chmod +x winetricks && sudo cp winetricks /usr/local/bin
```

To work correctly it also requie cabextract to work so install it with this command ```sudo apt-get install cabextract -y ```.

If you didn't link wine binaries to /usr/local/bin/ , you need to point to wine binary with WINE environment variable. Also you need to use three more variables - BOX86_NOBANNER=1 BOX64_LOG=0 BOX64_NOBANNER=1 so you can run it with command like `WINE=~/wine/bin/wine BOX86_NOBANNER=1 BOX64_LOG=0 BOX64_NOBANNER=1 winetricks dxvk`

Small info about DXVK. When I'm writing this article, Turnip in armhf version SIGBUS on calling vkResetQueryPoolEXT. 64-bit app can run fine, but VK implementation is still experimental.

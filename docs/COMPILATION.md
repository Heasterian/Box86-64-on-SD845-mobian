# COMPILATION

This part is simple and for base you can just use this command 

```
git clone https://github.com/ptitSeb/box86 && git clone https://github.com/ptitSeb/box64 && cd box64 && mkdir build && cd build && cmake .. -DSD845=1 && make -j8 && sudo make install && cd ../../box86 && mkdir build && cd build && cmake .. -DSD845=1 && make -j8 && sudo make install
```

Now restart systemd-binfmt so box86/64 will be called automatically `sudo systemctl restart systemd-binfmt`.

Now you should be able to run some apps... Unless you arent missing some libs. In case of problems, go part of mu guide about troubleshooting.

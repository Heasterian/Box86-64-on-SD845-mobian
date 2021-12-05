# TROUBLESHOOTING

Now, let's talk about some "issues" you can meet while using box'es.

So at the beginning you will have problems when starting apps due to missing dependent libraries in native armhf/aarch64 versions or i386/amd64 if they are not wrapped.

For native libs it will look like this.
```
Error initializing native libSDL2_ttf.so (last dlerror is libSDL2_ttf-2.0.so.0: cannot open shared object file: No such file or directory)
```

In this case you need to find package containing libSDL2_ttf-2.0.so.0 if you are using box86 in armhf version, if box64, in aarch64.

If word "native" is misisng, it means you need to download i386 or amd64 version of deb and put it in BOX86_LD_LIBRARY_PATH or BOX64_LD_LIBRARY_PATH. Personally, I created separate directories for them and just gather libs inside them to not duplicate files as they repeat in many games.

You can search packages with required lib files using `apt-file search` or this website: https://www.debian.org/distrib/packages

If you can't find some libs as they are deprecated like libpng12-0, you can try to start app wihoout them using `BOX86_ALLOWMISSINGLIBS=1` environment variable. Some app won't work this way, but for example Half Life 2 works fine like this.

There are cases when you will see information about missing symbols, syscalls or opcode and app crashes after it. First you should do is updating your box86/64 source with `git pull` and build last version. If issue still happens on newest version of emulator, open issue on git about it.

As box86 have lowest logging level set up, in case of crash you may want to run app with `BOX86_LOG=1` to see more informations about your situation before opening issue.

# EDGE CASES

There are two libs that are edge cases because you sometimes need one certain version of library to match required by app symbols: libssl.so and libcrypto.so. If you can find them in game directory, make sure that they are in BOX86_LD_LIBRARY_PATH or BOX86_LD_LIBRARY_PATH. They should work fine emulated and in mosta cases you don't need to search for certain version for ARM.

PPSSPP builder for iOS
======================

Requirements:
--------------
cmake  
dpkg  
ldid  
xcode  

How to use it:
--------------

* cd to the ppsspp-builder folder and from the command line run:
    git submodule update --init --recursive

* if you want to build an ipa
    make ipa
            
* if you want to build an deb
    make deb

* if you want to build both ipa and deb
    make all

*Notice:
--------------
PPSSPP used to have an issue with JIT, that with the latest commits have been resolved -- i.e. JIT is no longer working on iOS platforms, the IR interpreter should be used instead. In the future, this repo will be updated to support MoltenVK with dylibs on iOS. Also will be exploring auto-building/auto-release for AltStore.

Credits:
--------------
Thank you Halo-Michael for your initial build scripts. Simplified them somewhat to make it easier.

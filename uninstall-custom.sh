#!/bin/sh -e

# Install for OS X 10.9 based on:
# https://wiki.ccs.neu.edu/display/GPC/pcl-trunk+on+OS+X+10.9+with+homebrew




printf "\n\nUninstalling OpenNI\n"
printf "****************************\n\n"


for f in `ls /usr/local/lib/libni*`; do niReg -u $f; done
for f in `cat bin-installed.txt`; do rm -f /usr/local/bin/$f; done
for f in `cat lib-installed.txt`; do rm -f /usr/local/lib/$f; done
rm -rf /usr/local/include/ni
rm -rf /usr/local/etc/openni
sudo rm -rf /etc/openni
rm -f /usr/local/lib/pkgconfig/*openni*.pc


printf "\n*** DONE ***\n\n"

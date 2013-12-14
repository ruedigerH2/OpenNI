#!/bin/sh -e

# Install for OS X 10.9 based on:
# https://wiki.ccs.neu.edu/display/GPC/pcl-trunk+on+OS+X+10.9+with+homebrew


# make Redist first, in Platform/Linux/CreateRedist run RedistMaker
# you might need doxygen installed


printf "\n\nInstalling OpenNI\n"
printf "****************************\n\n"


cd Platform/Linux/Redist
D=`ls -d *-Bin*`
V=`expr $D : ".*-v\(.*\)"`
cd $D
F=openni-dev.pc
mv ../../../../$F $F

sed -e "s/VERSION/$V/" $F.in > $F


# utilities
printf "copying executables..."
ls /usr/local/bin > bin-orig.txt
cp Bin/ni* Samples/Bin/x64-Release/Ni* /usr/local/bin
ls /usr/local/bin > bin-new.txt
diff bin-orig.txt bin-new.txt | cut -d' ' -f2 | grep -E 'ni.*|Ni.*' > ../../../../bin-installed.txt


# copy libraries
printf "copying shared libraries..."
ls /usr/local/lib > lib-orig.txt
cp Lib/libOpenNI.* Lib/libni* /usr/local/lib
ls /usr/local/lib > lib-new.txt
diff lib-orig.txt lib-new.txt | cut -d' ' -f2 | grep -E 'libni.*|libOpenNI.*' > ../../../../lib-installed.txt


# include files
printf "copying include files..."
mkdir -p /usr/local/include/ni
cp -R Include/* /usr/local/include/ni/



# register modules
printf "registering modules... "
mkdir -p /usr/local/etc/openni
for f in `ls /usr/local/lib/libni*`; do niReg $f; done



cp Samples/Config/SamplesConfig.xml /usr/local/etc/openni/

cp openni-dev.pc /usr/local/lib/pkgconfig

# at least in git 28d22bca (8/30/13) pcl trunk uses a hardcoded path /etc/openni/SamplesConfig.xml on Apple
sudo mkdir /etc/openni
sudo ln -s /usr/local/etc/openni/SamplesConfig.xml /etc/openni


printf "\n*** DONE ***\n\n"

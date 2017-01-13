#!/bin/bash

set -e
installPath="$1"

if [ ! -f "$installPath/bin/cmake" ]
then
    echo "Installing Cmake 3.6.2 into $installPath"
    echo "$(uname) $(uname -m)"

    downloadUrl="none"
    if [ "$(uname)" == "Darwin" ]
    then
        downloadUrl="https://cmake.org/files/v3.6/cmake-3.6.2-Darwin-x86_64.tar.gz"
    else
        downloadUrl="https://cmake.org/files/v3.6/cmake-3.6.2-Linux-x86_64.tar.gz"
    fi

    echo "Downloading $downloadUrl"
    downloadPath="/tmp/cmake-3.6.2.tar.gz"
    curl -o $downloadPath $downloadUrl

    mkdir -p $installPath
    tar -xvf $downloadPath -C $installPath
    rm $downloadPath

    if [ `ls $installPath | wc -l` == 1 ]; then
      subdir=`ls $installPath`
      mv $installPath/$subdir/* $installPath/
      rmdir $installPath/$subdir
    fi

    if [ "$(uname)" == "Darwin" ]
    then
      subdir=`ls $installPath`
      mv $installPath/$subdir/Contents/* $installPath/
      rm -rf $installPath/$subdir
    fi
else
   echo "Looks like Cmake 3.6.2 is already installed into $installPath"
fi
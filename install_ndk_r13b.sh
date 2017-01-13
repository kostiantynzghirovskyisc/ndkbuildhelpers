#!/bin/bash

set -e
installPath="$1"

if [ ! -f "$installPath/source.properties" ]
then
    echo "Installing Android NDK r13b into $installPath"
    echo "$(uname) $(uname -m)"

    downloadUrl="none"
    if [ "$(uname)" == "Darwin" ]
    then
        downloadUrl="https://dl.google.com/android/repository/android-ndk-r13b-darwin-x86_64.zip"
    else
        downloadUrl="https://dl.google.com/android/repository/android-ndk-r13b-linux-x86_64.zip"
    fi

    echo "Downloading $downloadUrl"
    downloadPath="/tmp/android-ndk-r13b.zip"
    curl -o $downloadPath $downloadUrl

    unzip $downloadPath -d $installPath
    rm $downloadPath

    if [ `ls $installPath | wc -l` == 1 ]; then
      subdir=`ls $installPath`
      mv $installPath/$subdir/* $installPath/
      rmdir $installPath/$subdir
    fi
else
   echo "Looks like Android NDK r13b is already installed into $installPath"
fi
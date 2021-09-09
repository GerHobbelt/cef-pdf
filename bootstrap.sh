#bin/bash

echo "== Bootstrap Begin =="

CEF_DIR=cef
CEF_FILE=cef_binary_3.3325.1750.gaabe4c4_linux64
CEF_ARCHIVE=$CEF_FILE.tar.bz2

if [ ! -f $CEF_DIR ]; then
  rm -rf $CEF_FILE
  rm -rf $CEF_ARCHIVE
  wget https://cef-builds.spotifycdn.com/$CEF_ARCHIVE
  tar -xvf $CEF_ARCHIVE
  mv ./$CEF_FILE ./cef/
  rm -rf $CEF_ARCHIVE
fi

echo "== Bootstrap End =="
#!/usr/bin/bash
set -x

#install wget
WGET_PATH=`which wget`

if [ -z $WGET_PATH ]; then
	echo 'wget is not installed'
	echo 'Install WGET_PATH'
	sudo apt install wget -y
else
	echo 'wget is installed'
fi

# install unzip
UNZIP_PATH=`which unzip`

if [ -z $UNZIP_PATH ]; then
	echo 'unzip is not installed'
	echo 'Install unzip'
	sudo apt install unzip -y
else
	echo 'unzip is installed'
fi

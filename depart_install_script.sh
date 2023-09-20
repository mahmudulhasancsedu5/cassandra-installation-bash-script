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

#download depart

# https://github.com/mahmudulhasancsedu5/cassandra-depart/archive/refs/heads/depart_multinode.zip
DEPART_URL="https://github.com/mahmudulhasancsedu5/cassandra-depart/archive/refs/heads/depart_multinode.zip"

USER_HOME=`echo ~`
DEPART_HOME="$USER_HOME/depart"
ZIP_FILE_NAME='depart_multinode.zip' # <git-branch-name>.git
UNZIP_FOLDER_NAME='cassandra-depart-depart_multinode' # <git-reponame>-<git-branch-name>
DEPART_FOLDER_NAME='depart'


cd $USER_HOME

#download depart
ZIP_FILE="$USER_HOME/$ZIP_FILE_NAME"
if [ ! -f $ZIP_FILE -a ! -d $DEPART_HOME ]; then
	echo "$ZIP_FILE: downloading"
	wget $DEPART_URL
	echo "Download Completed"
	
else
	echo "$ZIP_FILE already exist"
fi


if [ -f $ZIP_FILE -a ! -d "$USER_HOME/$UNZIP_FOLDER_NAME" ]; then
	echo "unzip file"
	unzip $ZIP_FILE
	echo "unzip completed"
fi

if [ ! -d $DEPART_HOME ]; then
	echo "rename $UNZIP_FOLDER_NAME to $DEPART_FOLDER_NAME"
	mv "$USER_HOME/$UNZIP_FOLDER_NAME" "$DEPART_HOME"
	echo "rename completed"
fi


echo "depart folder: $DEPART_HOME"



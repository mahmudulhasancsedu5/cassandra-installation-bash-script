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

#download cassandra5

# https://github.com/mahmudulhasancsedu5/cassandra-ucs/archive/refs/heads/CASSANDRA-18397.zip
CASSANDRA5_URL="https://github.com/mahmudulhasancsedu5/cassandra-ucs/archive/refs/heads/CASSANDRA-18397.zip"

USER_HOME=`echo ~`
CASSANDRA5_HOME="$USER_HOME/cassandra5"
ZIP_FILE_NAME='CASSANDRA-18397.zip' # <git-branch-name>.git
UNZIP_FOLDER_NAME='cassandra-ucs-CASSANDRA-18397' # <git-reponame>-<git-branch-name>
CASSANDRA5_FOLDER_NAME='cassandra5'


cd $USER_HOME

#download cassandra5
ZIP_FILE="$USER_HOME/$ZIP_FILE_NAME"

if [ ! -f $ZIP_FILE -a ! -d $CASSANDRA5_HOME ]; then
	echo "$ZIP_FILE: downloading"
	wget $CASSANDRA5_URL
	echo "Download Completed"
	
else
	echo "$ZIP_FILE already exist"
fi


if [ -f $ZIP_FILE -a ! -d "$USER_HOME/$UNZIP_FOLDER_NAME" ]; then
	echo "unzip file"
	unzip $ZIP_FILE
	echo "unzip completed"
fi

if [ ! -d $CASSANDRA5_HOME ]; then
	echo "rename $UNZIP_FOLDER_NAME to $CASSANDRA5_FOLDER_NAME"
	mv "$USER_HOME/$UNZIP_FOLDER_NAME" "$CASSANDRA5_HOME"
	echo "rename completed"
fi


echo "cassandra5 folder: $CASSANDRA5_HOME"
echo "clean: ant realclean"
echo "build: ant"
echo "run: bin/cassandra -f"



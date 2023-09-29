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

# https://github.com/Labnann/cassandra/archive/refs/heads/add-depart-to-sharafat.zip
CUCKOO_URL="https://github.com/Labnann/cassandra/archive/refs/heads/add-depart-to-sharafat.zip"

USER_HOME=`echo ~`
CUCKOO_HOME="$USER_HOME/depart_cuckoo"
ZIP_FILE_NAME='add-depart-to-sharafat.zip' # <git-branch-name>.git
UNZIP_FOLDER_NAME='cassandra-add-depart-to-sharafat' # <git-reponame>-<git-branch-name>
CUCKOO_FOLDER_NAME='depart_cuckoo'

cd $USER_HOME

#download depart
ZIP_FILE="$USER_HOME/$ZIP_FILE_NAME"
if [ ! -f $ZIP_FILE -a ! -d $CUCKOO_HOME ]; then
	echo "$ZIP_FILE: downloading"
	wget $CUCKOO_URL
	echo "Download Completed"
	
else
	echo "$ZIP_FILE already exist"
fi


if [ -f $ZIP_FILE -a ! -d "$USER_HOME/$UNZIP_FOLDER_NAME" ]; then
	echo "unzip file"
	unzip $ZIP_FILE
	echo "unzip completed"
fi

if [ ! -d $CUCKOO_HOME ]; then
	echo "rename $UNZIP_FOLDER_NAME to $CUCKOO_FOLDER_NAME"
	mv "$USER_HOME/$UNZIP_FOLDER_NAME" "$CUCKOO_HOME"
	echo "rename completed"
fi


echo "depart folder: $CUCKOO_HOME"



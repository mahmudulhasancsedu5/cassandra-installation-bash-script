set -x

# prerequisit

# install tar for download maven
TAR_PATH=`which tar`

if [ -z $TAR_PATH ]; then
	echo 'tar is not installed'
	echo 'Install curl'
	sudo apt install tar -y
else
	echo 'tar already installed'
fi


# install curl for download maven
CURL_PATH=`which curl`

if [ -z $CURL_PATH ]; then
	echo 'curl is not installed'
	echo 'Install curl'
	sudo apt install curl -y
else
	echo 'curl already installed'
fi



# install ant
ANT_PATH=`which ant`


if [ -z $ANT_PATH ]; then
	echo 'ant not found. Install ant'
	sudo apt-get update
	sudo apt install ant -y
else
	echo 'ant is already installed'
fi

# install maven for depart

MVN_PATH=`which mvn`
if [ ! -z $MVN_PATH ]; then
	echo 'mvn alreay installed'
	exit 1
fi

#download maven
MVN_DOWNLOAD_URL='https://dlcdn.apache.org/maven/maven-3/3.9.4/binaries/apache-maven-3.9.4-bin.tar.gz'
MVN_TARBALL='apache-maven-3.9.4-bin.tar.gz'
MVN_FOLDER_NAME='apache-maven-3.9.4'
USER_HOME=`echo ~`

cd $USER_HOME

if [ ! -f $MVN_TARBALL ]; then
	echo 'Download maven tarball'
	curl -OL $MVN_DOWNLOAD_URL
else
	echo 'maven tarball already downloaded'
fi


# unzip maven

M2_HOME="$USER_HOME/$MVN_FOLDER_NAME"

if [ ! -d $M2_HOME ]; then
	echo 'unzipping maven'
	tar xzvf $MVN_TARBALL
	echo 'maven unzip completed'
else
	echo 'maven already unziped'
fi

BASH_RC="$USER_HOME/.bashrc" # ". .bashrc" # test
MAVEN_TEXT='M2_HOME'

if grep -F "$MAVEN_TEXT" $BASH_RC
then
        echo "M2_HOME is already in environment PATH"
else
        echo 'M2_HOME is not in PATH. Set M2_HOME in path'
	echo "export M2_HOME=$M2_HOME" >> $BASH_RC
	echo 'export PATH=$M2_HOME/bin:$PATH' >> $BASH_RC
	. $BASH_RC
fi



echo "***To complete installation run terminal cmd: source $BASH_RC ***"

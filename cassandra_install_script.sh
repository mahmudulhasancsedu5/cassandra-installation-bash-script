# install java

# install java openjdk-8-jdk
OPENJDK_VERSION="openjdk-8-jdk"
JAVA_HOME_DIR="/usr/lib/jvm/java-8-openjdk-amd64"

if [ -d $JAVA_HOME_DIR ]; then
	echo "Java already installed"
else 
	echo "Java is not installed"
	echo "Java install start"
	sudo apt-get update
	sudo apt-get -y install $OPENJDK_VERSION
	
fi

USER_HOME=`echo ~` # '.' # Find current user home directory path
DOT_PROFILE="$USER_HOME/.profile" # "./.profile" # test

echo "Need to set $OPENJDK_VERSION environment variable in $DOT_PROFILE"
if [ -d $JAVA_HOME_DIR ]; then
	cd
	pwd
	echo "Java is installed properly. Set environment variable JAVA_HOME"
	echo "export JAVA_HOME=$JAVA_HOME_DIR" >> $DOT_PROFILE
	echo 'export PATH=$JAVA_HOME/bin:$PATH' >> $DOT_PROFILE
	. .profile # source $DOT_PROFILE
else 
	echo "Java Installed folder not found"
fi

echo "JAVA_HOME directory: $JAVA_HOME_DIR"


# install cassandra

# install curl er download cassandra
CURL_PATH=`which curl`

if [ -z $CURL_PATH ]; then
	echo 'curl is not installed'
	echo 'Install curl'
	sudo apt install curl -y
else
	echo 'curl is installed'
fi

TAR_PATH=`which tar`

if [ -z $TAR_PATH ]; then
	echo 'tar is not installed'
	echo 'Install tar'
	sudo apt install tar -y
else
	echo 'tar is installed'
fi

# make dir for cassandra
USER_HOME=`echo ~`
CASSANDRA_DIR="$USER_HOME/cassandra" 

if [ ! -d $CASSANDRA_DIR ]; then
	echo "$CASSANDRA_DIR: directory does not exist"
	echo "Create directory: $CASSANDRA_DIR"
	cd $USER_HOME
	mkdir $CASSANDRA_DIR 
else
	echo "$CASSANDRA_DIR directory already exist"
fi


# Dowload cassandra
cd $CASSANDRA_DIR

CASSANDRA_VERSION="4.0.11"
TARBALL_NAME="apache-cassandra-$CASSANDRA_VERSION-bin.tar.gz"
CASSANDRA_FOLDER_NAME="apache-cassandra-$CASSANDRA_VERSION"
CASSANDRA_HOME="$CASSANDRA_DIR/$CASSANDRA_FOLDER_NAME"
TARBALL_URL="https://archive.apache.org/dist/cassandra/$CASSANDRA_VERSION/$TARBALL_NAME"

if [ ! -f "$CASSANDRA_DIR/$TARBALL_NAME" ]; then
	echo 'Download cassandra'
	cd $CASSANDRA_DIR
	curl -OL $TARBALL_URL
	
	echo 'cassandra download completed'
	
else
	echo 'cassandra already downloaded's
fi


if [ ! -d $CASSANDRA_HOME ]; then
	echo 'cassandra not unzip'
	tar xzvf $TARBALL_NAME
	
	echo 'cassandra unzip completed'
	
else
	echo 'cassandra already unziped'
fi

echo "CASSANDRA_HOME folder: $CASSANDRA_HOME"


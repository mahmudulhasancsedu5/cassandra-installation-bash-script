# check java verson
set -x

which java

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
JAVA_HOME_TEXT='JAVA_HOME'

if grep -F "$JAVA_HOME_TEXT" $DOT_PROFILE
then
    	echo "$JAVA_HOME_TEXT is already in environment PATH"
else
	cd $USER_HOME
	echo "export JAVA_HOME=$JAVA_HOME_DIR" >> $DOT_PROFILE
	echo 'export PATH=$JAVA_HOME/bin:$PATH' >> $DOT_PROFILE
    	. $DOT_PROFILE
fi



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
# DOT_PROFILE="$USER_HOME/.profile" # "./.profile" # test
BASH_RC="$USER_HOME/.bashrc" # ". .bashrc" # test

echo "Need to set $OPENJDK_VERSION environment variable in $BASH_RC"
JAVA_HOME_TEXT='JAVA_HOME'

if grep -F "$JAVA_HOME_TEXT" $BASH_RC
then
    	echo "$JAVA_HOME_TEXT is already in environment PATH"
else
	cd $USER_HOME
	echo "export JAVA_HOME=$JAVA_HOME_DIR" >> $BASH_RC
	echo 'export PATH=$JAVA_HOME/bin:$PATH' >> $BASH_RC
    	. $BASH_RC
fi

echo "Run cmd: source $BASH_RC"



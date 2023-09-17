#download YCSB

set -x

YCSB_URL='https://github.com/brianfrankcooper/YCSB/releases/download/0.17.0/ycsb-0.17.0.tar.gz'
YCSB_TARBALL='ycsb-0.17.0.tar.gz'
USER_HOME=`echo ~`
YCSB_DIR="$USER_HOME/YCSB"
YCSB_HOME="$USER_HOME/YCSB/ycsb-0.17.0"

# install curl er download cassandra
CURL_PATH=`which curl`

if [ -z $CURL_PATH ]; then
	echo 'curl is not installed'
	echo 'Install curl'
	sudo apt install curl -y
else
	echo 'curl already installed'
fi

TAR_PATH=`which tar`

if [ -z $TAR_PATH ]; then
	echo 'tar is not installed'
	echo 'Install tar'
	sudo apt install tar -y
else
	echo 'tar is installed'
fi

cd $USER_HOME

if [ ! -d $YCSB_DIR ]; then
	mkdir $YCSB_DIR
fi

cd $YCSB_DIR


if [[ ! -f "$YCSB_DIR/$YCSB_TARBALL" ]] && [[ ! -d $YCSB_HOME ]]; then
	echo "Download YCSB"
	curl -O --location $YCSB_URL
	
else
	echo "YCSB: already downloaded"
fi

if [ ! -d $YCSB_HOME ]; then
	if [ -f "$YCSB_DIR/$YCSB_TARBALL" ]; then
		echo 'YCSB not unzip'
		tar xzvf $YCSB_TARBALL
		echo 'YCSB unzip completed'
	
	else
		echo "$YCSB_DIR/$YCSB_TARBALL does not exist"
	fi
else
	echo "$YCSB_HOME already exist"
fi


cd $YCSB_HOME

echo "YCSB location: $YCSB_HOME"




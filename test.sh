set -x

YCSB_URL='https://github.com/brianfrankcooper/YCSB/releases/download/0.17.0/ycsb-0.17.0.tar.gz'
YCSB_TARBALL='ycsb-0.17.0.tar.gz'
USER_HOME=`echo ~`
YCSB_DIR="$USER_HOME/YCSB"
YCSB_HOME="$USER_HOME/YCSB/ycsb-0.17.0"


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


set -x

# make dir for cassandra
CASSANDRA_VERSION="4.0.11"
CASSANDRA_FOLDER_NAME="apache-cassandra-$CASSANDRA_VERSION"
USER_HOME=`echo ~`
CASSANDRA_DIR="$USER_HOME/cassandra"
CASSANDRA_HOME="$CASSANDRA_DIR/$CASSANDRA_FOLDER_NAME"

# Cnfigure cassandra

if [ ! -d $CASSANDRA_HOME ]; then
	echo "$CASSANDRA_HOME: directory does not exist"
	exit 1
fi

CASSANDRA_YAML="$CASSANDRA_HOME/conf/cassandra.yaml"
CASSANDRA_BASE_YAML="$CASSANDRA_HOME/conf/cassandra-base.yaml"


# make a backup copy of cassandra.yaml file


if [ ! -f $CASSANDRA_BASE_YAML ]; then
	echo "save a copy of original cassandra.yaml"
	cp $CASSANDRA_YAML $CASSANDRA_BASE_YAML
fi

if [ -f $CASSANDRA_BASE_YAML ]; then
	echo "copy  from cassandra-base.yaml for cassandra configuration setup"
	cp $CASSANDRA_BASE_YAML $CASSANDRA_YAML
fi

# remove cassandra previous data
rm -rf "$CASSANDRA_HOME/data/*"

IP_ADDRESS=`hostname -I` # for ec2 machine private ip will be cassandra node IP_ADDRESS
SEEDS[0]='192.168.0.105'
SEEDS[1]='192.168.0.103'

# update cassandra configuration

sed -i "s/cluster_name: 'Test Cluster'/cluster_name: 'AWS Cassandra Cluster'/g" $CASSANDRA_YAML
sed -i "s/listen_address: localhost/listen_address: $IP_ADDRESS/g" $CASSANDRA_YAML
sed -i "s/rpc_address: localhost/rpc_address: $IP_ADDRESS/g" $CASSANDRA_YAML


function join { local IFS=","; shift; echo "$*"; }

ALL_SEEDS=`join , ${SEEDS[@]}`

sed -i 's/- seeds: "127.0.0.1:7000"/- seeds: "'${ALL_SEEDS[@]}'"/g' $CASSANDRA_YAML

echo "cassandra setup: completed"
echo "apache cassandra version: $CASSANDRA_VERSION"
echo "CASSANDRA_HOME: $CASSANDRA_HOME"
echo "start cassandra cmd: bin/cassandra -f"
echo "exit cassndra: (ctl + c)"



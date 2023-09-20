set -x

# make dir for cassandra

USER_HOME=`echo ~`

DEPART_HOME="$USER_HOME/depart"

# Cnfigure cassandra

if [ ! -d $DEPART_HOME ]; then
	echo "$DEPART_HOME: directory does not exist"
	exit 1
fi

CASSANDRA_YAML="$DEPART_HOME/conf/cassandra.yaml"
CASSANDRA_BASE_YAML="$DEPART_HOME/conf/cassandra-base.yaml"


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
rm -rf "$DEPART_HOME/data/*"

IP_ADDRESS=`hostname -I` # for ec2 machine private ip will be cassandra node IP_ADDRESS
SEEDS[0]='192.168.0.105'
SEEDS[1]='192.168.0.103'

# update cassandra configuration

sed -i "s/cluster_name: 'Depart Cluster'/cluster_name: 'AWS Depart Cluster'/g" $CASSANDRA_YAML
sed -i "s/listen_address: 192.168.0.103/listen_address: $IP_ADDRESS/g" $CASSANDRA_YAML
sed -i "s/rpc_address: 192.168.0.103/rpc_address: $IP_ADDRESS/g" $CASSANDRA_YAML


function join { local IFS=","; shift; echo "$*"; }

ALL_SEEDS=`join , ${SEEDS[@]}`

sed -i 's/- seeds: "192.168.0.103,192.168.0.105"/- seeds: "'${ALL_SEEDS[@]}'"/g' $CASSANDRA_YAML

echo "depart setup: completed"
echo "DEPART_HOME: $DEPART_HOME"
echo "start depart cmd: bin/cassandra -f"
echo "exit cassndra: (ctl + c)"



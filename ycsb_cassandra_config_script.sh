set -x

USER_HOME=`echo ~`
YCSB_DIR="$USER_HOME/YCSB"
YCSB_HOME="$USER_HOME/YCSB/ycsb-0.17.0"

cd $YCSB_HOME
mvn -pl site.ycsb:cassandra-binding -am clean package

IP_ADDRESS=`hostname -I`
WORKLOAD_TYPE='workloada'
RECORD_COUNT=1000

# load cassandra data

bin/ycsb load cassandra-cql -P "workloads/$WORKLOAD_TYPE" -p hosts="$IP_ADDRESS" -s -p columnfamily=usertable -p recordcount="$RECORD_COUNT"

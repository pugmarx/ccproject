#!/bin/sh

f=`basename $0`
subtask=${f%.sh}
base=`dirname $0`/..
#echo $base

. ./optparams.sh

if [ $# -eq 4 ] 
then
    echo "Input: "$1,$2,$3,$4
else
    echo "Error!! Format is: $f <Origin_Code> <Transit> <Dest_Code> <Date>"
    exit 1
fi

echo "............................................................................................... "
echo "          3.2 X -> Y -> Z "
echo "............................................................................................... "

echo "............................................................................................... "
echo "          1/4. Execute Hadoop job"
echo "............................................................................................... "

hadoop jar ${base}/jars/${subtask}.jar airline/stage/2008 ${subtask} $1 $2 $3 $4 $HDP_OPTS

echo "............................................................................................... "
echo "          2/4. Raw Output"
echo "............................................................................................... "

mkdir -p ${base}/results
#hadoop fs -getmerge ${subtask} ${base}/results/${subtask}.csv
hadoop fs -cat ${subtask}_leg1/* > ${base}/results/${subtask}.csv
hadoop fs -cat ${subtask}_leg2/* >> ${base}/results/${subtask}.csv
cat ${base}/results/${subtask}.csv

echo "............................................................................................... "
echo "          3/4. Storing results in Cassandra"
echo "............................................................................................... "

cqlsh -f ${base}/cqls/${subtask}_setup.cql
cqlsh -f ${base}/cqls/${subtask}_save.cql

echo "............................................................................................... "
echo "          4/4. Output results from Cassandra"
echo "............................................................................................... "

cqlsh -e "SELECT leg, carrier, fltnum, deptime, depdate, delay FROM airline.airport_connect where origin='${1}'
and transit='${2}' and destination='${3}'"

echo "............................................................................................... "
echo "          Done"
echo "............................................................................................... "

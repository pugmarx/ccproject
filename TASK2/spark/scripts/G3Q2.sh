#/bin/sh

f=`basename $0`
subtask=${f%.sh}
s=${f%.sh}
base=`dirname $0`/..

#. ./optparams.sh

if [ $# -eq 5 ]
then
    echo $1 "::" $2 "::" $3 "::" $4 "::" $5
else
    echo "Error!! Format is: $f <KafkaTopic> <OriginCode> <TransitCode> <DestCode> <dd/MM/YYYY>"
    exit 1
fi


echo "............................................................................................... "
echo "          3.2 X->Y->Z Optimal flight based on constraints"
echo "............................................................................................... "

echo "............................................................................................... "
echo "          1/3. Execute Spark job"
echo "............................................................................................... "
#hadoop fs -rm -r output/${subtask}

spark-submit --packages org.apache.spark:spark-streaming-kafka-0-8_2.11:2.2.0,datastax:spark-cassandra-connector:2.0.5-s_2.11 --master spark://ip-172-31-71-230.ec2.internal:7077  --class org.pgmx.spark.g3.G3Q2 original-spark-examples_2.11-2.2.0.jar $2 $3 $4 $5 ip-172-31-76-34.ec2.internal:9092,ip-172-31-76-34.ec2.internal:9093,ip-172-31-76-34.ec2.internal:9094 $1 40 10000 Y ip-172-31-71-230.ec2.internal

echo "............................................................................................... "
echo "          2/3. Raw output"
echo "............................................................................................... "
hadoop fs -cat output/G3Q2/LEG_1/*
hadoop fs -cat output/G3Q2/LEG_2/*

echo "............................................................................................... "
echo "          3/2. Output from Cassandra"
echo "............................................................................................... "

cqlsh -e "select * from t2.g3q2 where origin='LAX' and transit='MIA' and dest='LAX' and leg='LEG_1' and startdate='2008-05-16' LIMIT 1"
cqlsh -e "select * from t2.g3q2 where origin='LAX' and transit='MIA' and dest='LAX' and leg='LEG_2' and startdate='2008-05-16' LIMIT 1"
cqlsh -e "select * from t2.g3q2"

echo "............................................................................................... "
echo "          Done"
echo "............................................................................................... "

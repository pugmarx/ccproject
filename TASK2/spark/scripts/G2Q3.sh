#/bin/sh

f=`basename $0`
subtask=${f%.sh}
s=${f%.sh}
base=`dirname $0`/..

#. ./optparams.sh

if [ $# -eq 3 ]
then
    echo $1 "::" $2 "::" $3
else
    echo "Error!! Format is: $f <KafkaTopic> <OriginCode> <DestCode>"
    exit 1
fi


echo "............................................................................................... "
echo "          2.3 X ➝ Y: (Airline, Average delay in minutes)"
echo "............................................................................................... "

echo "............................................................................................... "
echo "          1/3. Execute Spark job"
echo "............................................................................................... "
#hadoop fs -rm -r output/${subtask}

spark-submit --packages org.apache.spark:spark-streaming-kafka-0-8_2.11:2.2.0,datastax:spark-cassandra-connector:2.0.5-s_2.11 --master spark://ip-172-31-71-230.ec2.internal:7077  --class org.pgmx.spark.g2.G2Q3 jar/original-spark-examples_2.11-2.2.0.jar $2 $3 ip-172-31-76-34.ec2.internal:9092,ip-172-31-76-34.ec2.internal:9093,ip-172-31-76-34.ec2.internal:9094 $1 40 10000 Y ip-172-31-71-230.ec2.internal


echo "............................................................................................... "
echo "          2/3. Raw output"
echo "............................................................................................... "

#hadoop fs -cat output/G2Q3/*
hadoop fs -getmerge output/G2Q3 .g2q3.tmp
head -10 .g2q3.tmp

echo "............................................................................................... "
echo "          2/3. Output from Cassandra"
echo "............................................................................................... "

cqlsh -e "select * from t2.g2q3 where origin='$2' and dest='$3' limit 10"


echo "............................................................................................... "
echo "          Done"
echo "............................................................................................... "

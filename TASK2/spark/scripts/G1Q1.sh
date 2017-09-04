#/bin/sh

f=`basename $0`
subtask=${f%.sh}
s=${f%.sh}
base=`dirname $0`/..

#. ./optparams.sh

if [ $# -eq 1 ]
then
    echo "KafkaTopic: "$1
else
    echo "Error!! Format is: $f <KafkaTopic>"
    exit 1
fi


echo "............................................................................................... "
echo "          1.1 Airport: Number of flights in/out"
echo "............................................................................................... "

echo "............................................................................................... "
echo "          1/2. Execute Spark job"
echo "............................................................................................... "
#hadoop fs -rm -r output/${subtask}

spark-submit --packages org.apache.spark:spark-streaming-kafka-0-8_2.11:2.2.0,datastax:spark-cassandra-connector:2.0.5-s_2.11 --master spark://ip-172-31-71-230.ec2.internal:7077  --class org.pgmx.spark.g1.G1Q1 jar/original-spark-examples_2.11-2.2.0.jar ip-172-31-76-34.ec2.internal:9092,ip-172-31-76-34.ec2.internal:9093,ip-172-31-76-34.ec2.internal:9094 $1 40 10000 Y ip-172-31-71-230.ec2.internal

echo "............................................................................................... "
echo "          2/2. Raw output"
echo "............................................................................................... "


#hadoop fs -cat output/G1Q1/* | head -10
hadoop fs -getmerge output/G1Q1 .g1q1.tmp
head -10 .g1q1.tmp

echo "............................................................................................... "
echo "          Done"
echo "............................................................................................... "

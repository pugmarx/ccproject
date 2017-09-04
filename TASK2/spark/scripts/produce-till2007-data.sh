#!/bin/bash


############################
# Extracts the zip files from the mounted /data dir
# Cleans the data by
# 1. Extracting relevant columns
# 2. Removing unnecessary characters
#
# Data is then copied over to the corresponding hdfs location.
###########################

if [ $# -eq 1 ]
then
    echo "KafkaTopic: "$1
else
    echo "Error!! Format is: $f <KafkaTopic>"
    exit 1
fi

for i in {1988..2007}
do
	echo ":::: Processing directory $i ::::"	
	#hdfs dfs -rm -r airline/stage/$i
	hadoop fs -cat airline/stage1/$i/* | kafka-console-producer.sh --broker-list ip-172-31-76-34.ec2.internal:9092,ip-172-31-76-34.ec2.internal:9093,ip-172-31-76-34.ec2.internal:9094 --topic $1 > progress.out
done

#!/bin/sh

if [ $# -eq 1 ]
then
    echo "KafkaTopic: "$1
else
    echo "Error!! Format is: $f <KafkaTopic>"
    exit 1
fi


pv 2008.filtered | kafka-console-producer.sh --broker-list ip-172-31-76-34.ec2.internal:9092,ip-172-31-76-34.ec2.internal:9093,ip-172-31-76-34.ec2.internal:9094 --topic $1 > progress.out

#!/bin/sh

if [ $# -eq 1 ]
then
    echo $1
else
    echo "Error!! Format is: $f <KafkaTopic>"
    exit 1
fi

kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 40 --topic $1

echo "Topics are:"
kafka-topics.sh --list --zookeeper localhost:2181

#!/bin/sh

if [ $# -eq 1 ]
then
    echo $1 
else
    echo "Error!! Format is: $f <KafkaTopic>" 
    exit 1
fi

kafka-topics.sh --zookeeper localhost:2181 --delete --topic $1

echo "Remaining topics are:"
kafka-topics.sh --list --zookeeper localhost:2181

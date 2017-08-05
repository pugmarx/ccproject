#!/bin/sh

f=`basename $0`
s=${f%.sh}

. ./optparams.sh

echo "............................................................................................... "
echo "		1.2 Airline: Average delay in minutes"
echo "............................................................................................... "

echo "............................................................................................... "
echo "		1/2. Execute Hadoop job"
echo "............................................................................................... "

hadoop jar ../jars/$s.jar airline/stage $s $HDP_OPTS

echo "............................................................................................... "
echo "		2/2. Output results"
echo "............................................................................................... "

hadoop fs -cat $s/*

echo "............................................................................................... "
echo "		Done"
echo "............................................................................................... "


#!/bin/bash
for i in {1999..2008}
do
	for f in `find /home/ubuntu/data/aviation/airline_ontime/$i -name "*.zip"`; do echo --$f--; unzip -o $f; y=`basename $f`; z=${y%.zip}.csv;hdfs dfs -mkdir -p airline/raw/$i; hdfs dfs -copyFromLocal $z airline/raw/$i; rm -f $z;  done;
done

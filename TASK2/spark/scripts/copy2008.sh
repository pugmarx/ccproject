#!/bin/sh

#for i in {2008}
#do
i=2008
	echo ":::: Processing directory $i ::::"	
	hdfs dfs -rm -r airline/raw/$i
	for f in `find /home/ubuntu/data/aviation/airline_ontime/$i -name "*.zip"`; do echo --$f--;y=`basename $f`; z=${y%.zip}.csv; unzip -o $f; hdfs dfs -mkdir -p airline/raw/$i; hdfs dfs -copyFromLocal $z airline/raw/$i; rm -f $z *.html; done;
#done

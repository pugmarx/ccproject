#!/bin/bash


############################
# Extracts the zip files from the mounted /data dir
# Cleans the data by
# 1. Extracting relevant columns
# 2. Removing unnecessary characters
#
# Data is then copied over to the corresponding hdfs location.
###########################


for i in {1988..2008}
do
	#for f in `find /home/ubuntu/data/aviation/airline_ontime/$i -name "*.zip"`; do echo --$f--; unzip -o $f; y=`basename $f`; z=${y%.zip}.csv;hdfs dfs -mkdir -p airline/raw/$i; hdfs dfs -copyFromLocal $z airline/raw/$i; rm -f $z;  done;
	echo ":::: Processing directory $i ::::"	
	hdfs dfs -rm -r airline/stage/$i
	for f in `find /home/ubuntu/data/aviation/airline_ontime/$i -name "*.zip"`; do echo --$f--; unzip -o $f;y=`basename $f`; z=${y%.zip}.csv; k=${z%.csv}.filtered.csv; awk -vFPAT='[^,]*|"[^"]*"' '{if(NR>1)printf("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n",$1,$6,$24,$5,$7,$11,$12,$18,$26,$35,$37,$42) }' $z | sed 's/\"//g' > $k; hdfs dfs -mkdir -p airline/stage/$i; hdfs dfs -copyFromLocal $k airline/stage/$i; rm -f $z $k *.html; done;
done

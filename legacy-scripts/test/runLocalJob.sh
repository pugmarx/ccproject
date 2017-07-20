#!/bin/bash
#hdfs dfs -mkdir -p airline/stage/$1
for c in {2008..2008}
do
	hdfs dfs -rm -r airline/test_stage/$c
	hadoop jar hadoop-streaming-*.jar \
	  -D mapreduce.job.reduces=0 \
	  -D mapreduce.map.output.key.field.separator=',' \
	  -D mapreduce.partition.keypartitioner.options=-k1,2 \
	  -input airline/raw/$c \
	  -output airline/test_stage/$c \
	  -mapper myMapper.sh \
	  -file /home/ubuntu/ccproj/ccproject/legacy-scripts/test/myMapper.sh

	hdfs dfs -test -e airline/test_stage/$c/_SUCCESS
	OUT=$?
		if [ $OUT -eq 0 ];then
		echo "============ Job Succeeded ====="
		#hdfs dfs -rm -r airline/raw/$c
	else
		echo "========== Job FAILURE!!! ========="
		exit 1
	fi
done

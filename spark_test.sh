#!/usr/bin/env bash

. `dirname $0`/config.sh
action=${1:-"jar"}

OUTPUT_DIR=$BASE_DIR/output/spark

if [ "x$action" = "xjar" ];then
	cd $SPARK_TEST_WS
	scalac -sourcepath src -d bin src/graph/*.scala -cp $SPARK_TEST_CP
	jar cvf $BASE_DIR/test.jar -C $SPARK_TEST_WS/bin .
elif [ "x$action" = "xupload" ];then
	scp $BASE_DIR/test.jar $SPARK_TEST_USER@$SPARK_TEST_M:$SPARK_TEST_DIR
elif [ "x$action" = "xrun" ];then
	class=${2:-"graph.SSSPBig"}
	input=$3
	output=$4
	name=${class}_`basename $input`

	mkdir -p $OUTPUT_DIR/${name} || exit 1
	echo "ssh $SPARK_TEST_USER@$SPARK_TEST_M \"source /etc/profile;cd $SPARK_TEST_DIR;scala -classpath test.jar:$SPARK_TEST_CP $class $input $output\""
	ssh -n $SPARK_TEST_USER@$SPARK_TEST_M "source /etc/profile;cd $SPARK_TEST_DIR;scala -classpath test.jar:$SPARK_TEST_CP $class $input $output" > $OUTPUT_DIR/${name}/dout 2>&1

elif [ "x$action" = "xsummary" ];then
	class=${2:-"graph.SSSPBig"}
	input=$3
	name=${class}_`basename $input`

	#generate stage statistics
	cat $OUTPUT_DIR/${name}/dout | python $BASE_DIR/bin/stage.py > $OUTPUT_DIR/${name}/stages		
	#generate iteration statistics
	cat $OUTPUT_DIR/${name}/dout | python $BASE_DIR/bin/turn.py > $OUTPUT_DIR/${name}/turns
elif [ "x$action" = "xsummary_bagel" ];then
	name=${2:-"result"}		
	#generate stage statistics
	cat $OUTPUT_DIR/${name}/dout | python $BASE_DIR/bin/stage.py > $OUTPUT_DIR/${name}/stages		
	#generate iteration statistics
	cat $OUTPUT_DIR/${name}/dout | python $BASE_DIR/bin/superstep.py > $OUTPUT_DIR/${name}/turns
else
	printf "action $action is unknown \n"
	exit 1
fi

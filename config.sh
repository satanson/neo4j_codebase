#!/usr/bin/env bash 

BASE_DIR=`dirname $0`/..
BASE_DIR=`cd $BASE_DIR;pwd;`

#parameters for upload and run spark testsets.
SPARK_TEST_WS="/home/bsp/zhanghao/SparkTest"
SPARK_TEST_M="192.168.255.118"
SPARK_TEST_USER="bsp"
SPARK_TEST_DIR="/home/bsp/zhanghao/test_result/spark_test"
SPARK_TEST_CP="/home/bsp/programer/spark-0.8.0-incubating-bin-hadoop1/assembly/target/scala-2.9.3/spark-assembly_2.9.3-0.8.0-incubating-hadoop1.0.4.jar"

#parameters for run bsp testsets.
#BSP_TEST_USER="owner-pc"
#BSP_TEST_M="localhost"
#BSP_DIR="/home/owner-pc/mount/E/lab/graph/bsp"
#BSP_TEST_DIR="/home/owner-pc/mount/E/lab/graph/hao_test"

BSP_TEST_USER="bsp"
BSP_TEST_M="192.168.255.118"
BSP_DIR="/home/bsp/programer/bsp"
BSP_TEST_DIR="/home/bsp/zhanghao/hao_codes/hao_test"


#hama
HAMA_TEST_WS="/home/bsp/zhanghao/hama63test"
HAMA_TEST_M="192.168.255.118"
HAMA_TEST_USER="bsp"
HAMA_TEST_DIR="/home/bsp/zhanghao/test_result/hama_test"
HAMA_BASE_PACKAGE="org.apache.hama.examples"
HAMA_DIR="/home/bsp/programer/hama-0.6.3"

#neo
NEO_TEST_WS="/home/bsp/zhanghao/neo4j-server"
NEO_DIR="/home/bsp/programer/neo4j-enterprise-2.0.0"
NEO_DATA_DIR="${NEO_DIR}/data"
NEO_TEST_USER="bsp"
NEO_MACHINES="192.168.255.118 192.168.255.114 192.168.255.115 192.168.255.117"
NEO_INPUT_DIR="/home/bsp/zhanghao/input_data/cut_file/used_input"
NEO_JVM_ARGS="-Xmx10g"

#mapreduce
MR_TEST_WS="/home/bsp/zhanghao/hadoop"
MR_TEST_M="192.168.255.118"
MR_TEST_USER="bsp"
MR_TEST_DIR="/home/bsp/zhanghao/test_result/mr_test"
MR_BASE_PACKAGE="org.apache.hadoop.examples"

#performance test
PERF_TEST_USER=bsp
PERF_TEST_DIR=/home/bsp/zhanghao/perf_test
PERF_TEST_DIR_BIN=$PERF_TEST_DIR/bin
PERF_TEST_DIR_NETHOGS=$PERF_TEST_DIR/nethogs
PERF_TEST_DIR_TMPOUT=$PERF_TEST_DIR/tmp_out
PERF_TEST_DIST_SH=$BASE_DIR/bin/perf_dist.sh
PERF_TEST_TICKS_CPP=$BASE_DIR/bin/ticks.cpp
PERF_TEST_PROC_PY=$BASE_DIR/bin/perf_proc.py
PERF_TEST_MACHINE_FILE=$BASE_DIR/perf_test/conf/ms

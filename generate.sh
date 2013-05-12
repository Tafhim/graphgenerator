#!bin/bash

MODE=$1 
if [ "$MODE" = "single" ]; then
	MODEL=$2
	VARIABLE=$3
	COMPARE=$4
	if [ "$5" = "" ]; then
		echo "Considering current directory to have data"
		DATA=$(pwd)
	else
		DATA=$5
	fi
	exec /bin/bash $(pwd)/datafy.sh $MODEL $VARIABLE $COMPARE $DATA
fi 

if [ "$MODE" = "compare" ]; then
	echo "Still not done"
	exit 0
fi
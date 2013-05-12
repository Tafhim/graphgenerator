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
	/bin/bash $(pwd)/datafy.sh $MODEL $VARIABLE $COMPARE $DATA &
	
	if [ "$6" = "smooth" ]; then
		SETTING="using 1:2 smooth bezier"
	else
		SETTING="with lines"
	fi

	TITLE=$7
	if [ "$TITLE" = "" ]; then
		TITLE="notitle"
	fi
	X_AXIS=$8
	Y_AXIS=$9

	PROPERTIES="$SETTING $TITLE"

	rm $(pwd)/temp.conf
	touch $(pwd)/temp.conf
	CONFFILE=$(pwd)/temp.conf
	echo "set term pngcairo" > $CONFFILE
	echo "set xlabel \"$X_AXIS\"" >> $CONFFILE
	echo "set ylabel \"$Y_AXIS\"" >> $CONFFILE
	echo "set output \"$(pwd)/ouput\ $MODEL\ $VARIABLE\ $6.png\"" >> $CONFFILE 
	echo "plot \"$DATA/$MODEL/$VARIABLE/Data.txt\" $PROPERTIES" >> $CONFFILE
	cat $CONFFILE
	gnuplot $CONFFILE
	rm $DATA/$MODEL/$VARIABLE/Data.txt
	rm $(pwd)/temp.conf
fi 

if [ "$MODE" = "compare" ]; then
	MODEL1=$2
	MODEL2=$3
	VARIABLE=$4
	COMPARE=$5
	if [ "$6" = "" ]; then
		echo "Considering current directory to have data"
		DATA=$(pwd)
	else
		DATA=$6
	fi
	/bin/bash $(pwd)/datafy.sh $MODEL1 $VARIABLE $COMPARE $DATA
	/bin/bash $(pwd)/datafy.sh $MODEL2 $VARIABLE $COMPARE $DATA
	if [ "$7" = "smooth" ]; then
		SETTING="using 1:2 smooth bezier"
	else
		SETTING="with lines"
	fi
	TITLE1=$8
	if [ "$TITLE1" = "" ]; then
		TITLE1="notitle"
	fi
	TITLE2=$9
	if [ "$TITLE2" = "" ]; then
		TITLE2="notitle"
	fi
	X_AXIS=${10}
	Y_AXIS=${11}
	PROPERTIES1="$SETTING $TITLE1"
	PROPERTIES2="$SETTING $TITLE2"

	rm $(pwd)/temp.conf
	touch $(pwd)/temp.conf
	CONFFILE=$(pwd)/temp.conf
	echo "set term pngcairo" > $CONFFILE
	echo "set xlabel \"$X_AXIS\"" >> $CONFFILE
	echo "set ylabel \"$Y_AXIS\"" >> $CONFFILE
	echo "set output \"$(pwd)/ouput\ $MODEL1\ vs\ $MODEL2\ $VARIABLE\ $7.png\"" >> $CONFFILE 
	echo "plot \"$DATA/$MODEL1/$VARIABLE/Data.txt\" $PROPERTIES1, \"$DATA/$MODEL2/$VARIABLE/Data.txt\" $PROPERTIES2" >> $CONFFILE

	cat $CONFFILE
	gnuplot $CONFFILE
	rm $DATA/$MODEL1/$VARIABLE/Data.txt
	rm $DATA/$MODEL2/$VARIABLE/Data.txt
	rm $(pwd)/temp.conf	
fi
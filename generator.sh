#!bin/bash

echo "Generating for $1 [$2]";

DIR=$(pwd)/$1/$2;
QFILE="Qvalue.dat";
FIRST=""
SECOND=""\
PREV=""
rm $DIR/Data.txt
touch $DIR/Data.txt
for i in $(ls $DIR)
do
	if [ -d $DIR/$i ]; then
		DATA=$(cat $DIR/$i/$QFILE)
		#echo $DATA
		IFS=": " read -ra ADDR <<< "$DATA"
		for i in "${ADDR[@]}"; do			
			if [ "$PREV" = "$2" ]; then			
				FIRST=$i
			fi
			if [ "$PREV" = "Q" ]; then
				SECOND=$i
			fi
			PREV=$i
		done
		echo "$FIRST $SECOND" >> $DIR/Data.txt
	fi
done

#!bin/bash

echo "Generating for $1 [$2]";

DIR=$4/$1/$2;
QFILE="Qvalue.dat";
FIRST=""
SECOND=""
PREV=""
if [ ! -d $DIR/$(echo "1") ]; then
	echo "Not the working DIR"
	exit 1
fi
rm $DIR/Data.txt
touch $DIR/Data.txt

count=0
for i in $(ls $DIR)
do
	if [ -d $DIR/$i ]; then
		DATA=$(cat $DIR/$i/$QFILE)
		#echo $DATA
		IFS=": " read -ra ADDR <<< "$DATA"
		for i in "${ADDR[@]}"; do			
			#echo $count
			if [ "$PREV" = "$3" ]; then			
				FIRST=$i
				if [ "$2" = "RD" ]; then
					x=-15
					y=5
					FIRST=$(( $x+$count*$y ))
				fi
			fi
			if [ "$PREV" = "Q" ]; then
				SECOND=$i
			fi
			PREV=$i
		done
		echo "$FIRST $SECOND" >> $DIR/Data.txt
		((count++))
	fi
done

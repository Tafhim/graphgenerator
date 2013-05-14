#!bin/bash

RESTORE='\033[0m'
RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
LIGHTGRAY='\033[00;37m'
LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'

echo -e "${YELLOW}Generating for ${LGREEN}$1 ${RESTORE}[${LBLUE}$2${RESTORE}]";

DIR=$4/$1/$2;
QFILE="Qvalue.dat";
FIRST=""
SECOND=""
PREV=""
if [ ! -d $DIR/$(echo "1") ]; then
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
sort -k1 -n $DIR/Data.txt > $DIR/tempData.txt
sort -k1 -n $DIR/tempData.txt > $DIR/Data.txt
exit 0

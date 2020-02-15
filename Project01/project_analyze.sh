#!/bin/bash

if [ "$#" -gt 1 ] || [ "$#" -eq 0 ]; then
echo "Multiple(or zero) arguments are not allowed. Check README.md for clarification"
exit 1
fi


path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd)
cd "$path"

OIFS="$IFS"
IFS=$'\n'

if [ "$1" == 1 ] ; then

if [ -f fixme.log ]; then
	rm fixme.log
fi

touch fixme.log

for f in `find ../ -type f`
do
	if [ $(tail -1 "$f" | egrep ".*#FIXME.*") ] ; then
		fixmefile=CS1XA3$(echo "$f" | cut -c3-)
		echo "$fixmefile" >> fixme.log
	fi
done

elif [ "$1" == 2 ] ; then

for c in $(git log --oneline)
do
	if [ $(echo "$c" | egrep -i ".*merge.*") ]; then
	commit="${c%% *}" # delete the longest match of ' *' from the end
	git checkout "$commit"
	break
	fi

done


elif [ "$1" == 3 ] ; then

echo 'Type the extension you are looking for and hit enter'
read extension

let counter=0


for f in `find ../ -type f -name "*.$extension"`
do
	counter=$(($counter+1))
done

echo "There are $counter files of type .$extension in this repository"


elif [ "$1" == 4 ] ; then

echo "Type the tag and hit enter"
read tag

if [ -f "$tag.log" ]; then
rm "$tag".log
fi

touch "$tag".log

for f in `find ../ -type f -name "*.py"`
do
for line in `cat "$f"`
do
	if [ $(echo "$line" | egrep "^#.*$tag.*") ]; then
		tagfile=CS1XA3$(echo "$f" | cut -c3-)
		echo "$tagfile"$'\t'"$line" >> "$tag".log
	fi
done
done


else
	echo  "Inappropriate value for the argument. Check README.md for clarification."


fi

IFS="$OIFS"

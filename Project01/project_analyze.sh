#!/bin/bash

path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$path"

OIFS="$IFS"
IFS=$'\n'

if [ "$1" -eq 1 ] ; then

if [ -f fixme.log ]; then
	rm fixme.log
fi

touch fixme.log

for f in `find ../ -type f` # ??? | grep -v .git
do
	if [ $(tail -1 "$f" | egrep ".*#FIXME.*") ] ; then
		fixmefile=CS1XA3$(echo "$f" | cut -c3-)
		echo "$fixmefile" >> fixme.log
	fi
done

elif [ "$1" -eq 2 ] ; then

for c in $(git log --oneline)
do
	if [ $(echo "$c" | egrep -i ".*merge.*") ]; then
	commit="${c%% *}" # delete the longest match of ' *' from the end
	git checkout "$commit"
	break
	fi

done


elif [ "$1" -eq 3 ] ; then

echo 'Type the extension you are looking for and hit enter'
read extension

let counter=0


for f in `find ../ -type f -name "*.$extension" | grep -v .git`
do
	counter=$(($counter+1))
done

echo "There are $counter files of type .$extension in this repository"


elif [ "$1" -eq 4 ] ; then

echo "Type the tag and hit enter"
read tag

if [ -f "$tag.log" ]; then
rm "$tag".log
fi

touch "$tag".log

for f in `find ../ -type f -name "*.py" | grep -v .git`
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

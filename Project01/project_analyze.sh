#!/bin/bash

path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$path"

if [ "$1" -eq 1 ] ; then

if [ -f fixme.log ]; then 
	rm fixme.log
fi
touch fixme.log

OIFS="$IFS"
IFS=$'\n'
for f in `find ../ -type f | grep -v .git`
do
	if [ $(tail -1 "$f" | egrep "*#FIXME") ] ; then 
		echo "$f" >> fixme.log
	fi
done
IFS="$OIFS"

elif [ "$1" -eq 2 ] ; then

OIFS="$IFS"
IFS=$'\n'
for c in $(git log --oneline)
do
	if [ $(echo "$c" | egrep -i "*merge") ]; then	
	commit="${c%% *}" # delete the longest match of ' *' from the end
	git checkout "$commit" 
	break
	fi

done
IFS="$OIFS"
fi


#Replacing all the occurrence of the pattern in a line : The substitute flag /g (global replacement) specifies the sed command to replace all the occurrences of the string in the line.
#$sed 's/unix/linux/g' geekfile.txt

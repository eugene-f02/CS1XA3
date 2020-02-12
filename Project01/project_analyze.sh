#!/bin/bash

path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$path"

if [ "$1" -eq 1 ] ; then


dir=$(find ../ -type f | grep -v .git)


if [ -f fixme.log ]; then 
	rm fixme.log
fi
touch fixme.log


for f in $dir
do
	if [ $(tail -1 $f | egrep "*#FIXME") ] ; then 
		echo $f >> fixme.log
	fi
done


elif [ "$1" -eq 2 ] ; then

IFS=$'\n'
for c in $(git log --oneline)
do
	if [ $(echo "$c" | egrep -i "*merge") ]; then	
	commit="${c%% *}"
	git checkout "$commit" 
	break
	fi

done

fi


#Replacing all the occurrence of the pattern in a line : The substitute flag /g (global replacement) specifies the sed command to replace all the occurrences of the string in the line.
#$sed 's/unix/linux/g' geekfile.txt

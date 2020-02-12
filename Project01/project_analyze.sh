#!/bin/bash

path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$path"

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

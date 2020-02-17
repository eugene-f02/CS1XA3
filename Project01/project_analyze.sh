#!/bin/bash

calc_permission () {
let count=0
result=""
for i in {0..2}
do
        if [ $(echo "$1" | egrep "^(...){$i}r..") ]; then
                count=$(($count+4))
        fi
        if [ $(echo "$1" | egrep "^(...){$i}.w.") ]; then
                 count=$(($count+2))
        fi
        if [ $(echo "$1" | egrep "^(...){$i}..x") ]; then
                 count=$(($count+1))
        fi
        result="$result""$count"
        let count=0
done

echo "$result"
}



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

elif [ "$1" == "5" ]; then

echo "Type in whether you want to change or restore 'sh' files' permssions"

read option

if [ "$option" == "Change" ]; then

	if [ -f permissions.log ]; then
	rm permissions.log
	fi

	touch permissions.log

	for i in `find ../ -type f -name "*.sh"`
do
	echo "$i "$(calc_permission $(ls -l "$i" | cut -c2-10)) >> permissions.log
	if [ $(ls -l "$i" | egrep "^.(.w.){3}") ]; then
		chmod a+x "$i"
	elif [ $(ls -l "$i" | egrep "^.(.w.){2}") ]; then
		chmod  ug+x "$i"; chmod o-x "$i"
	elif [ $(ls -l "$i" | egrep "^.(.w.){1}") ]; then
		chmod u+x "$i"; chmod go-x "$i"
	else
		chmod a-x "$i"
	fi
done
elif [ "$option" == "Restore" ]; then
	for i in `cat permissions.log`
do
	chmod "${i##* }" "${i% *}"
done
else
	echo "Inappropriate input. Check README.md for clarification"
fi

elif [ "$1" == "6" ]; then

echo "Type in whether you want to backup or restore files"

read option

if [ "$option" == "Backup" ] ; then

if [ -d backup ]; then
rm -r backup
fi

mkdir backup
cd backup
touch restore.log
cd ..

for i in `find ../ -type f -name "*.tmp"`
do
	echo "${i##.*/}" "${i%/*}" >> ../Project01/backup/restore.log
	mv "$i" ../Project01/backup
done

elif [ "$option" == "Restore" ] ; then
cd backup

if [ -f restore.log ]; then

for i in `cat restore.log`
do
	if [ -f "${i%% ../*}" ]; then
	mv "${i%% ../*}" ../"${i##*tmp }"
	else
	echo "${i%% ../*}"  no longer exists
	fi
done

else
	echo "Error: restore.log no longer exists"
fi

else 
        echo "Inappropriate input. Check README.md for clarification"
fi



else
	echo  "Inappropriate value for the argument. Check README.md for clarification."

fi

IFS="$OIFS"



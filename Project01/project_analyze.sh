#!/bin/bash


generate_unique_randomID () {

isUnique=False

while [[ "$isUnique" == "False" ]]
do
	isUnique=True
	new_Id=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 6 | head -n 1)
	for i in "${IDs[@]}"
	do
		if [[ "$new_Id" == "$i" ]] ; then
			isUnique=False
			break
		fi
	done

done

echo "$new_Id"
}


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

elif [ "$1" == 5 ]; then

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
			var=$(ls -l "$i")
			if  [ ${var:2:1} == 'w' ]; then
				chmod u+x "$i"
			else
				chmod u-x "$i"
			fi

			if  [ ${var:5:1} == 'w' ]; then
        			chmod g+x "$i"
        		else
	        	        chmod g-x "$i"
			fi

			if  [ ${var:8:1} == 'w' ]; then
        			chmod o+x "$i"
        		else
        		        chmod o-x "$i"
			fi

			echo "Successfully changed permissions of CS1XA3"$(echo "$i" | cut -c3-)
		done

	elif [ "$option" == "Restore" ]; then
		if [ -f permissions.log ]; then
			for i in `cat permissions.log`
			do
				if [[ -f "${i% *}" ]]; then
					chmod "${i##* }" "${i% *}"
					echo "Successfully restored permissions of CS1XA3"$(echo "${i% *}" | cut -c3-)
				else
					echo CS1XA3$(echo "${i% *}" | cut -c3-) no longer exists
				fi
			done
		else
			echo "Error: permissions.log no longer exists"
		fi
	else
		echo "Inappropriate input. Check README.md for clarification"
	fi

elif [ "$1" == 6 ]; then

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
			echo "${i##*/}" "${i%/*}" >> ../Project01/backup/restore.log
			mv "$i" ../Project01/backup
			echo "Successfully moved CS1XA3"$(echo "$i" | cut -c3-)" to CS1XA3/Project01/backup"
		done

	elif [ "$option" == "Restore" ] ; then
		cd backup

		if [ -f restore.log ]; then

			for i in `cat restore.log`
			do
				if [ -f "${i%% ../*}" ]; then
					cp "${i%% ../*}" ../"${i##*tmp }"
					echo "Successfully restored CS1XA3"$( echo "${i##*tmp }"/"${i%% ../*}" | cut -c3-)
				else
					echo CS1XA3$( echo "${i##*tmp }""${i%% ../*}" | cut -c3-) no longer exists
				fi
			done

		else
			echo "Error: restore.log no longer exists"
		fi

	else
        	echo "Inappropriate input. Check README.md for clarification"
	fi

elif [ "$1" == modif ]; then

	echo "Type in the preffered time zone (EST or UTC):"
	read timeZone
	if [[ ! "$timeZone" =~ (^EST$|(^UTC$|^UTC(\+|-)((1[0-9]|2[0-4])|[0-9])$)) ]]; then
		echo "Error: You can only use either EST or UTC time zone. Check README.md for more information"
		exit 1
	fi

	if [ -d "Last Modifications" ]; then
		rm -r "Last Modifications"
	fi

	mkdir "Last Modifications"

	var=$(TZ="$timeZone" stat -c %y "Last Modifications");
        var=${var:0:10}
	echo "Using $timeZone time zone" >> "Last Modifications/info.txt"
	echo "This folder was created on $var" >> "Last Modifications/info.txt"
	for i in `find ../ -type f | grep -v .git | grep -v "../Project01/Last Modifications"`
	do
		fixmefile=CS1XA3$(echo "$i" | cut -c3-)
		var=$(TZ="$timeZone" stat -c %y "$i");
		var=${var:0:10}
		echo "${fixmefile}">> "Last Modifications/$var".log 
	done
	echo Done
elif [ "$1" == enc ]; then
	echo "Type in whether you want to encrypt all files in this repository, or decryt a particular one:"
	read option

cat >encryption.py << 'END'
import sys
content=sys.argv[1]
mode=int(sys.argv[2])
def enc(s,mode):
	result=''
	for i in s:
		if ord(i)>32 and ord(i)<126:
			result+=chr(ord(i)+mode)
		elif ord(i)==32:
			result+=chr(126)
		elif ord(i)==126:
			result+=chr(32)
		else:
			result+=i
	return  result
print(enc(content,mode))

END

	chmod +x encryption.py

	if [ "$option" == "Encrypt" ] ; then 

		if [ -f encryptions.txt ]; then
	                chmod g+r+w encryptions.txt
	                chmod o+r+w encryptions.txt

			for i in `cat encryptions.txt`
			do
				if [ -f "${i% *}" ]; then
        				content=`cat "${i% *}"`
        				python3 encryption.py "$content" -1 > "${i% *}"
				fi
			done
		rm encryptions.txt
		fi

		touch encryptions.txt
                chmod g+r+w encryptions.txt
                chmod o+r+w encryptions.txt


		IDs=()

		# i had this '../Project01$' as egrep -v ... why?

		for i in `find .. -type f | egrep -v '../Project01/encryption.py|../Project01/project_analyze.sh|../.git/|../Project01/encryptions.txt|../Project01/permissions.log|../Project01/backup/'`
		do
			content=`cat "$i"`
			newId=$(generate_unique_randomID)
			IDs+=("$newId")
			echo "${i}" "$newId" >> encryptions.txt
			python3 encryption.py "$content" 1 > "$i"
			echo "Successfully encrypted CS1XA3"$(echo "$i" | cut -c3-)
		done

		rm encryption.py
                chmod g-r-w-x encryptions.txt
                chmod o-r-w-x encryptions.txt

	elif [ "$option" == "Decrypt" ] ; then

		if [ ! -f encryptions.txt ]; then
			echo "The file encryptions.txt does not exist, thus there is nothing that you can decrypt"
			rm encryption.py
			IFS="$OIFS"
			exit 1
		fi

		echo "Type in the path to the file you want to decrypt relative to CS1XA3 folder:"
		read fileName

		if [[ "$fileName" == "all" ]] && [[ "$(stat -c "%u" encryptions.txt)" == "$(id -u)" ]] ; then
			for i in `cat encryptions.txt`
			do
				if [ -f "${i% *}" ]; then
                                        content=`cat "${i% *}"`
					python3 encryption.py "$content" -1 > "${i% *}"
                                	echo "Successfully decrypted CS1XA3"$(echo "${i% *}" | cut -c3-)
				else
                                        echo "CS1XA3"$(echo "${i% *}" | cut -c3-)" no longer exists"
				fi
                        done
                rm encryptions.txt
		rm encryption.py
		IFS="$OIFS"
		exit 1
		elif [[ "$fileName" == "all" ]]; then
			echo "You're not the owner of encryptions.txt and thus have no enough permissions to run this command"
                	rm encryption.py
			IFS="$OIFS"
			exit 1
		fi



		echo "Type in the decrytion code associated with this file:"
		read encId


		chmod g+r+w encryptions.txt
                chmod o+r+w encryptions.txt
		wasEncBefore=False
		for i in `cat encryptions.txt`
		do
			if [[ "${i% *}" == ../"$fileName" ]] ; then
				if [[ "${i##* }" == "$encId" ]] ; then
					wasEncBefore=True
					if [ -f "${i% *}" ]; then
						content=`cat "${i% *}"`
						python3 encryption.py "$content" -1 > "${i% *}"
						echo "Successfully decrypted CS1XA3"$(echo "${i% *}" | cut -c3-)
						sed -i "/.*${i##* }/d" encryptions.txt
						break
					else
						echo "CS1XA3"$(echo "${i% *}" | cut -c3-)" no longer exists"
						sed -i "/.*${i##* }/d" encryptions.txt
						break
					fi


				else
					wasEncBefore=True
					echo "Wrong decryption code for CS1XA3"$(echo "${i% *}" | cut -c3-)
					break
				fi
			else
				wasEncBefore=False
			fi
		done

		if [[ "$wasEncBefore" == "False" ]] ; then
			echo CS1XA3/"$fileName" either does not exist or was not encrypted
		fi

		rm encryption.py
		chmod g-r-w-x encryptions.txt
                chmod o-r-w-x encryptions.txt

	else
		echo "Inappropriate input. Check README.md for clarification"
		rm encryption.py

	fi

else
	echo  "Inappropriate value for the argument. Check README.md for clarification."
fi

IFS="$OIFS"


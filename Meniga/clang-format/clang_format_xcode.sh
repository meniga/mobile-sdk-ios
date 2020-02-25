#!/bin/bash

DIRECTORIES_TO_FORMAT=( "$@" )

for directory in "${DIRECTORIES_TO_FORMAT[@]}"
do

	command="git diff origin/master --name-only --relative ${directory}" 
	
	# if you want to reformat all files uncomment line below
	# command="find ${directory} -type f"

	diff=$(${command})
	for file in ${diff};
	do
		if [ -e ${file} ]; then
			if [[ ${file: -2} == ".h" || ${file: -2} == ".m" ]]; then
				echo Formatting ${file}
				$(dirname ${BASH_SOURCE})/clang-format -style=file $(pwd)/${file} -i
			fi
		fi
	done
done

exit 0

#!/bin/bash

# source https://unix.stackexchange.com/questions/175135/how-to-rename-multiple-files-by-replacing-string-in-file-name-this-string-conta

find . -name "*.png" -type f |
while read FILE; do
	cp "${FILE}" .
done

#find . -name "*zip*" -type f |
#while read FILE
#	do newfile="$(echo ${FILE} |sed -e 's/\&d=1//')"
#mv "${FILE}" "${newfile}" 
#done



# substitute more strings?
# https://gist.github.com/un33k/1162378 
#sed '/AAA/!d; /BBB/!d; /CCC/!d'

#sed 's/ab/~~/g; s/bc/ab/g; s/~~/bc/g'

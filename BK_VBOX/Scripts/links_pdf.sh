#!/bin/bash


#for file in `ls *.pdf`; do convert -verbose -colorspace RGB -resize 480 -interlace none -density 300 -quality 80 $file `echo $file | sed 's/\.pdf$/\.jpg/'`;done

#for f in *.pdf; do convert -thumbnail x300 -background white -alpha remove "$f"[0] "${f%.pdf}.png";done

#for f in *.pdf; do convert -thumbnail x800 -background white -alpha remove "$f"[0] "${f%.pdf}.png";done

# outputs all .jpg images in working directory into a list with <a> and <img src> tags

#echo \<ul\>

i=0
for file in *.pdf
do
	echo \<a href=docs\/apple_manuals\/"$file"\>\<img src=images\/"$file.png" /\>\</a\>
	i=`expr $i + 1`
done

#echo \</ul\>

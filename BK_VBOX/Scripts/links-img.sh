#!/bin/bash

# outputs all .jpg images in working directory into a list with <a> and <img src> tags

#echo \<ul\>

i=0
for pic in *.jpg
do
	echo \<a href=images\/"$pic"\>\<img src=images\/"$pic"_thumbnail.jpeg width=200 height=266 alt=$pic /\>\</a\>
	i=`expr $i + 1`
done

#echo \</ul\>

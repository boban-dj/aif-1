#!/bin/bash
# Create links from images, create thumbnails x100 from images
# For use in Bluefish, as Bluefish thumbnail quality is not so good


DIRECTORY="$PWD"
BASE_DIRECTORY=$(echo "$DIRECTORY" | cut -d "/" -f4)
echo "#$BASE_DIRECTORY#";
# Create links from images, create thumbnails x100 from images
# For use in Bluefish, as Bluefish thumbnail quality is not so good

# create the output directory for the resulting images
outdir=out
if test ! -d $outdir
then
    mkdir $outdir
fi

# for each possible image extension
#echo '<!-- -- -- -- -->' >>mkthumb.html
for ext in .png .PNG .GIF .gif .jpg .bmp
do

# define the type conversions
if test $ext = ".bmp"
then
oext=.png
elif test $ext = ".GIF"
then
oext=.gif
elif test $ext = ".PNG"
then
oext=.png
else
oext=$ext
fi

# for each image with the current extension
for i in *$ext

# no image available with the given extension
do
if test ! -f "$i"
then
    break
fi

# echo image that is being converted
#echo -n $i

# "alt" tag name for each file
b=`basename "$i" $ext`

# create one thumbnail image
t="$b-thumb$oext"
convert +dither -thumbnail 'x100>' -colors 256 "$i"[1] $outdir/"$t"

# create one big image
#convert "$i" -scale 'x512>' -strip $outdir/"$b$oext"

# add width to output
w=`identify -format %w $outdir/"$t"`

# create the fragment of image table
#echo '' >>mkthumb.html
#echo '<div class="imgtab">' >>mkthumb.html
#echo '<div class="imgtab-l">' >>mkthumb.html
echo '<a href="'$b$oext'" class="img">' #>>mkthumb.html
echo '<img src="out/'$t'" height="100" width="'$w'" alt="'$b'"/></a>' #>>mkthumb.html
#echo '</div>' >>mkthumb.html
#echo '<div class="imgtab-r">' >>mkthumb.html
#echo '</div>' >>mkthumb.html
#echo '<div class="imgtab-end"></div>' >>mkthumb.html
#echo '</div>' >>mkthumb.html

# optimize sizes ??
#if test $oext = ".png"
#then
#mv $outdir/$b$oext $outdir/tmp-$b$oext
#mv $outdir/$t $outdir/tmp-$t
#pngout.exe $outdir/tmp-$b$oext $outdir/$b$oext
#pngout.exe $outdir/tmp-$t $outdir/$t
#rm $outdir/tmp-$b$oext
#rm $outdir/tmp-$t
#fi

#echo " done"

done
done


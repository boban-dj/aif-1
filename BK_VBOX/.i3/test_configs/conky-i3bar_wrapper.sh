#!/bin/sh

# Short version:
#echo "{\"version\": 1}"
#echo "["
#echo "[]"
#conky -c ~/.i3/i3conky

# Send the header so that i3bar knows we want to use JSON:
echo '{"version":1}'
# Begin the endless array.
echo '['
# We send an empty first array of blocks to make the loop simpler:
echo '[],'
# Now send blocks with information forever:
exec conky -c $HOME/.i3/i3conky
#exec conky -c $HOME/.i3/i3conky_nick/conkyrc_nick

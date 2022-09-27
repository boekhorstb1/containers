PWD=$(pwd)
UPDATEDIR="$PWD/.github/workflows/*"

#!/bin/bash
# NOTE : Quote it else use array to avoid problems #
for f in $UPDATEDIR
do
  echo "Processing $f file..."
  # take action on each file. $f store current file name
  sed -i 's+ghcr.io/maintaina/containers+ghcr.io/boekhorstb1/containers+g' $f
done

# need to add some code to change the images pulled in the FROM part of base/

PWD=$(pwd)
UPDATEDIR="$PWD/.github/workflows/*"

#!/bin/bash
# NOTE : Quote it else use array to avoid problems #
for f in $UPDATEDIR
do
  echo "Processing $f file..."
  # take action on each file. $f store current file name
  sed -i 's+ghcr.io/boekhorstb1/containers+ghcr.io/maintaina/containers+g' $f
done

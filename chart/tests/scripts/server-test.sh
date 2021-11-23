#!/bin/bash
set -e

echo "Checking for sealed info in 'vault status' output"
ATTEMPTS=10
n=0
until [ "$n" -ge $ATTEMPTS ]
do
  echo "Attempt" $n...
  vault status -format yaml | grep -E '^sealed: (true|false)' && break
  n=$((n+1))
  sleep 5
done
if [ $n -ge $ATTEMPTS ]; then
  echo "timed out looking for sealed info in 'vault status' output"
  exit 1
fi

exit 0

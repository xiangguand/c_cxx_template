#!/usr/bin/env bash
### Author: Xiang Guan Deng.

./build.sh

if [ ! -d "./test" ]; then
  echo "Test directory not found."
fi

ret=0
for testfile in ./test/*; do
  if [ -x "$testfile" ]; then
    "$testfile"
    if [ $? -ne 0 ]; then
      ret=$((ret+1))
    fi
  else
    echo "Skipping $testfile as it's not executable."
  fi
done

if [ $ret -eq 0 ]; then
  echo "Test scripts are all pass."
else
  echo "Test cases fail."
fi

exit $ret

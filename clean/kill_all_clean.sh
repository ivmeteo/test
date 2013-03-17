#!/bin/bash

for p in `ps -A | grep clean | awk '{ print $1 }'`
do
  echo "killing $p-process"
  #kill $p
done
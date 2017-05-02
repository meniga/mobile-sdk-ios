#!/bin/sh

for hook in "uniquify-hook.sh";
do
  sh "$(pwd)/git-hooks/$hook"
  if [ $? -ne 0 ]; then
    exit 1
  fi
done

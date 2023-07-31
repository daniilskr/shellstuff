#!/bin/bash

# Simple and really flawed script to find (potentially) unused vue components
# Needs some tuning depending on project structure

FILES="resources/js/components/organizms/*"
for f in $FILES
do
    bname=$(basename "$f")
    tname=$(echo "$bname" | sed -r 's/([a-z0-9])([A-Z])/\1-\L\2/g')
    matches=$(git grep -Pi "(\<$bname|\<$tname)" | grep -v "public/js/app.js:" | grep -v "resources/js/components/organizms/index.js:" | egrep -v "^public/.*")
    cnt=$(echo "$matches" | grep -vc '^$')
    printf "\n\n\n$bname ($cnt)\n"
    echo "$matches"
done

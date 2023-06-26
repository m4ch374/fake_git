#!/bin/dash

pigs_dir=".pig"

if test -e "$pigs_dir"
then
    echo "$0: error: $pigs_dir already exists" >&2
    exit 1
fi

mkdir "$pigs_dir"
echo "Initialized empty pigs repository in $pigs_dir"

#!/bin/dash

# =====================================
# Error checking
# =====================================
default_repo=".pig"

if ! test -d "$default_repo"
then
    echo "$0: error: pigs repository $default_repo not found"
    exit 1
fi 

if [ $# -eq 0 ]
then
    echo "usage: $0 <filenames>"
    exit 1
fi

for file in "$@"
do
    if ! test -e "$file"
    then
        echo "$0: error: can not open '$file'" 
        exit 1
    fi 
done 

# ======================================
# Main
# ======================================
index_file="./$default_repo/index"
objects_file="./$default_repo/objects"

for file in "$@"
do 
    content_hash="$(sha1sum "$file" | sed -nE "s/^(.*) +.*$/\1/p")"
    cat "$file" > "$objects_file/$content_hash"
    echo "$file $content_hash" >> "$index_file"
done 

#!/bin/dash

# =====================================
# Syntax checking
# =====================================
default_repo=".pig"

if ! test -d "$default_repo"
then
    echo "$0: error: pigs repository directory $default_repo not found"
    exit 1
fi 

if [ $# -eq 0 ]
then
    echo "usage: $0 <filenames>"
    exit 1
fi

# ======================================
# Main
# ======================================
index_file="./$default_repo/index"
objects_file="./$default_repo/objects"

# populate index file, treat it as temp tree
branch_info="$default_repo/BRANCHES"
curr_branch=$(cat $default_repo/HEAD)
curr_tree=$(cat $branch_info | grep -E "^$curr_branch" | cut -d' ' -f2)

if ! [ "$curr_tree" = "empty" ]
then
    cat "$objects_file/$curr_tree" >> "$index_file"
fi 
tmp=$(sort -u "$index_file")
echo "$tmp" > "$index_file"

# check if file exist in index
for file in "$@"
do
    if ! (grep -E "^$file" "$index_file" > /dev/null || test -f "$file")
    then
        echo "$0: error: can not open '$file'" 
        exit 1
    fi 
done 

tmp_idx=$(mktemp)

if [ -n "$(cat "$index_file")" ]
then 
    cat "$index_file" >> "$tmp_idx"
fi

for file in "$@"
do 
    # might introduce lost pointers, will fix later
    if ! test -f "$file"
    then
        continue
    fi 

    content_hash="$(sha1sum "$file" | cut -d' ' -f1)"

    if [ -z "$(cat "$file")" ]
    then
        : >  "$objects_file/$content_hash"
    else 
        cat "$file" > "$objects_file/$content_hash"
    fi 
    echo "$file $content_hash" >> "$tmp_idx"
done 

sort -u "$tmp_idx" > "$index_file"
rm "$tmp_idx"

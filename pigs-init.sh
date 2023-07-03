#!/bin/dash

pigs_dir=".pig"

if test -e "$pigs_dir"
then
    echo "$0: error: $pigs_dir already exists" >&2
    exit 1
fi

mkdir "$pigs_dir"

# initialize index file
touch "$pigs_dir/index"

# initialize object file
mkdir "$pigs_dir/objects"

default_branch_name="master"

# initialize branch infos
echo "$default_branch_name" > "$pigs_dir/BRANCHES"

# initialize curr head
echo "$default_branch_name" > "$pigs_dir/HEAD"

# not really empty lol
echo "Initialized empty pigs repository in $pigs_dir"

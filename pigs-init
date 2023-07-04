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
echo "$default_branch_name empty" > "$pigs_dir/BRANCHES"

# initialize curr head
echo "$default_branch_name" > "$pigs_dir/HEAD"

# initialize log file
mkdir "$pigs_dir/logs"
touch "$pigs_dir/logs/$default_branch_name"

# initialize commit history
mkdir "$pigs_dir/commits"
touch "$pigs_dir/commits/$default_branch_name"

# not really empty lol
echo "Initialized empty pigs repository in $pigs_dir"

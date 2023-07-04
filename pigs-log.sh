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

if ! [ $# -eq 0 ]
then
    echo "usage: $0"
    exit 1
fi

curr_branch=$(cat $default_repo/HEAD)
cat "$default_repo/logs/$curr_branch"

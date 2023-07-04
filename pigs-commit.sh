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

error_msg="usage: $0 [-a] -m commit-message"

if [ $# -eq 0 ]
then
    echo "$error_msg"
    exit 1
fi

if ! [ "$1" = "-m" ]
then
    echo "$error_msg"
    exit 1
fi

if [ -z "$2" ]
then
    echo "$error_msg"
    exit 1
fi 

commit_msg="$2"

# =====================================
# main
# =====================================
no_commits="nothing to commit"
branch_info="$default_repo/BRANCHES"
index_file="$default_repo/index"

staged_files=$(cat $index_file)
staged_files_hash=$(sha1sum "$index_file" | cut -d' ' -f1)

curr_branch=$(cat $default_repo/HEAD)
curr_tree=$(cat $branch_info | grep -E "^$curr_branch" | cut -d' ' -f2)

log_file="$default_repo/logs/$curr_branch"
if { [ -z "$(cat "$log_file")" ] && [ -z "$staged_files" ]; } || [ "$curr_tree" = "$staged_files_hash" ]
then
    echo "$no_commits"
    exit 0
fi 

if [ -z "$staged_files" ]
then
    : > "$default_repo/objects/$staged_files_hash"
else 
    echo "$staged_files" > "$default_repo/objects/$staged_files_hash"
fi 

new_info=$(sed -E "s/^$curr_branch .*$/$curr_branch $staged_files_hash/" "$branch_info")
echo "$new_info" > "$branch_info"
: > "$index_file"

commit_num=0
if [ -n "$(cat "$log_file")" ]
then
    curr_num=$(tail -n1 "$log_file" | cut -d' ' -f1)
    commit_num=$((curr_num + 1))
fi 

history_file="$default_repo/commits/$curr_branch"

echo "$commit_num $commit_msg" >> "$log_file"
echo "$commit_num $staged_files_hash" >> "$history_file"
echo "Committed as commit $commit_num"

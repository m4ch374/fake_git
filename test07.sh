#!/bin/dash

# Copy and pasting most of my stuff cuz im lazy lol

# =============================
# Setup
# =============================
my_dir=$(mktemp -d)
ref_dir=$(mktemp -d)

my_out=$(mktemp)
ref_out=$(mktemp)

passed="\033[32mPassed\e[0m"
failed="\e[1;31mFailed\e[0m"

PATH="$PATH:$(pwd)"
export PATH

# =============================
# Subset 2 - Normal usage && merge w/ FF
# =============================

echo ""
echo "Subset 2 - Normal usage && merge w/ FF"
echo "======================================"

# ===================================================
echo "Normal usage && merge w/ FF"
cd "$my_dir" || exit 1
{
    pigs-init
    echo some > a
    pigs-add a
    pigs-commit -m a
    pigs-branch b1
    pigs-branch -d master
    pigs-checkout another 
    pigs-checkout b1
    echo another >> a
    pigs-commit -a -m a
    pigs-merge master -m merge
    pigs-checkout master
    pigs-merge b1 -m merge
    pigs-branch -d b1
    pigs-status
} >> "$my_out" 2>> "$my_out"

cd "$ref_dir" || exit 1
{
    2041 pigs-init
    echo some > a
    2041 pigs-add a
    2041 pigs-commit -m a
    2041 pigs-branch b1
    2041 pigs-branch -d master
    2041 pigs-checkout another 
    2041 pigs-checkout b1
    echo another >> a
    2041 pigs-commit -a -m a
    2041 pigs-merge master -m merge
    2041 pigs-checkout master
    2041 pigs-merge b1 -m merge
    2041 pigs-branch -d b1
    2041 pigs-status
} >> "$ref_out" 2>> "$ref_out"

if diff "$my_out" "$ref_out" > /dev/null
then
    echo "$passed"
else 
    echo "$failed"
fi 
echo ""

: > "$my_out"
: > "$ref_out"

rm -rf "$my_dir" "$ref_dir" "$my_out" "$ref_out"

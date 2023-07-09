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
# Subset 0 - Normal usages
# =============================

echo ""
echo "Subset 0 - Normal usages"
echo "======================================"

# ===================================================
echo "Normal usages"
cd "$my_dir" || exit 1
{
    pigs-init
    touch a b c
    pigs-add a
    pigs-commit -m "a"
    pigs-log
    pigs-add b
    pigs-commit -m "b"
    pigs-log 
    pigs-add c
    pigs-commit -m "c"
    pigs-log
    touch d
    pigs-commit -m "No commits"
    pigs-log
    echo some >> a
    pigs-show :a
    pigs-add a
    pigs-show :a
    pigs-show 0:a
    pigs-show 1:b
    pigs-show 2:c
} >> "$my_out"

cd "$ref_dir" || exit 1
{
    2041 pigs-init
    touch a b c
    2041 pigs-add a
    2041 pigs-commit -m "a"
    2041 pigs-log
    2041 pigs-add b
    2041 pigs-commit -m "b"
    2041 pigs-log 
    2041 pigs-add c
    2041 pigs-commit -m "c"
    2041 pigs-log
    touch d
    2041 pigs-commit -m "No commits"
    2041 pigs-log
    echo some >> a
    2041 pigs-show :a
    2041 pigs-add a
    2041 pigs-show :a
    2041 pigs-show 0:a
    2041 pigs-show 1:b
    2041 pigs-show 2:c
} >> "$ref_out"

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

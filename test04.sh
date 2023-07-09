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
# Subset 1 - Normal usage
# =============================

echo ""
echo "Subset 1 - Normal usage"
echo "======================================"

# ===================================================
echo "Normal usage"
cd "$my_dir" || exit 1
{
    pigs-init
    echo hi > a
    echo another > b
    echo more > c
    pigs-status
    pigs-add a b c
    pigs-rm --cached a
    pigs-status
    pigs-commit -m "b c"
    pigs-show 0:a
    pigs-show 0:b
    pigs-show 0:c
    cat a
    pigs-rm a 
    pigs-rm --force a
    pigs-status
} >> "$my_out" 2>> "$my_out"

cd "$ref_dir" || exit 1
{
    2041 pigs-init
    echo hi > a
    echo another > b
    echo more > c
    2041 pigs-status
    2041 pigs-add a b c
    2041 pigs-rm --cached a
    2041 pigs-status
    2041 pigs-commit -m "b c"
    2041 pigs-show 0:a
    2041 pigs-show 0:b
    2041 pigs-show 0:c
    cat a
    2041 pigs-rm a 
    2041 pigs-rm --force a
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

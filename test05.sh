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
# Subset 1 - Advanced usage
# =============================

echo ""
echo "Subset 1 - Advanced usage"
echo "======================================"

# ===================================================
echo "Advanced usage"
cd "$my_dir" || exit 1
{
    pigs-init
    echo hi > a
    echo another > b
    echo more > c
    pigs-status
    pigs-add a
    pigs-rm b c
    pigs-rm a
    pigs-commit -m "a"
    pigs-status 
    rm a
    pigs-status 
    pigs-rm a
    pigs-status
    pigs-add b c
    pigs-status
    echo more >> b
    pigs-status 
    pigs-rm b
    pigs-status 
    pigs-commit -a -m "c"
    pigs-status 
    echo hihi >> c
    pigs-status 
    pigs-add b
    pigs-commit -a -m "b c"
    pigs-status
} >> "$my_out" 2>> "$my_out"

cd "$ref_dir" || exit 1
{
    2041 pigs-init
    echo hi > a
    echo another > b
    echo more > c
    2041 pigs-status
    2041 pigs-add a
    2041 pigs-rm b c
    2041 pigs-rm a
    2041 pigs-commit -m "a"
    2041 pigs-status 
    rm a
    2041 pigs-status 
    2041 pigs-rm a
    2041 pigs-status
    2041 pigs-add b c
    2041 pigs-status
    echo more >> b
    2041 pigs-status 
    2041 pigs-rm b
    2041 pigs-status 
    2041 pigs-commit -a -m "c"
    2041 pigs-status 
    echo hihi >> c
    2041 pigs-status 
    2041 pigs-add b
    2041 pigs-commit -a -m "b c"
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

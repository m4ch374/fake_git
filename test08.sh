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
# Subset 2 - Advanced usage
# =============================

echo ""
echo "Subset 2 - Advanced usage"
echo "======================================"

# ===================================================
echo "3 way merge without conflicts"
cd "$my_dir" || exit 1
{
    pigs-init
    touch a
    pigs-add a
    pigs-commit -m a
    pigs-branch b1
    echo some >> a
    echo another >> b
    pigs-add a b
    pigs-commit -m ab
    pigs-checkout b1
    pigs-status
    echo hihi > c
    pigs-add c
    pigs-commit -m c
    pigs-checkout master
    pigs-merge b1 -m merge
    pigs-status
} >> "$my_out" 2>> "$my_out"

cd "$ref_dir" || exit 1
{
    2041 pigs-init
    touch a
    2041 pigs-add a
    2041 pigs-commit -m a
    2041 pigs-branch b1
    echo some >> a
    echo another >> b
    2041 pigs-add a b
    2041 pigs-commit -m ab
    2041 pigs-checkout b1
    2041 pigs-status
    echo hihi > c
    2041 pigs-add c
    2041 pigs-commit -m c
    2041 pigs-checkout master
    2041 pigs-merge b1 -m merge
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

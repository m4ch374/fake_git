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

# =============================
# Subset 0 - Advanced usage
# =============================

echo ""
echo "Subset 0 - Advanced usage"
echo "======================================"

# ===================================================
echo "Advanced usage"
cd "$my_dir" || exit 1
{
    pigs-init
    touch a b c
    pigs-show :a
    pigs-show :b
    pigs-show :c
    pigs-add a
    pigs-log 
    echo some >> a
    pigs-commit -a -m "a"
    pigs-show 0:a
    pigs-log 
    echo another >> b
    echo more >> c
    pigs-commit -a -m "no commits"
    pigs-add b c 
    pigs-commit -m "b c"
    pigs-log 
    pigs-show :b
    pigs-show :c
    pigs-show 0:b
    pigs-show 0:c
    pigs-show 1:b
    pigs-show 1:c
    pigs-log
} >> "$my_out" 2>> "$my_out"

cd "$ref_dir" || exit 1
{
    2041 pigs-init
    touch a b c
    2041 pigs-show :a
    2041 pigs-show :b
    2041 pigs-show :c
    2041 pigs-add a
    2041 pigs-log 
    echo some >> a
    2041 pigs-commit -a -m "a"
    2041 pigs-show 0:a
    2041 pigs-log 
    echo another >> b
    echo more >> c
    2041 pigs-commit -a -m "no commits"
    2041 pigs-add b c 
    2041 pigs-commit -m "b c"
    2041 pigs-log 
    2041 pigs-show :b
    2041 pigs-show :c
    2041 pigs-show 0:b
    2041 pigs-show 0:c
    2041 pigs-show 1:b
    2041 pigs-show 1:c
    2041 pigs-log
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
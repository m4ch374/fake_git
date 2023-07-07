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
# Subset 0 - Test errors
# =============================

echo ""
echo "Subset 0 - Test errors"
echo "======================================"

# ===================================================
echo "Commands invoked without .pig"
cd "$my_dir" || exit 1
{
    pigs-add a
    pigs-commit -m "message"
    pigs-log
    pigs-show :a 
} 2>> "$my_out"

cd "$ref_dir" || exit 1
{
    2041 pigs-add a
    2041 pigs-commit -m "message"
    2041 pigs-log
    2041 pigs-show :a 
} 2>> "$ref_out"

if diff "$my_out" "$ref_out" > /dev/null
then
    echo "$passed"
else 
    echo "$failed"
fi 
echo ""

: > "$my_out"
: > "$ref_out"

# ===================================================
echo "Error output from: pigs-init"
cd "$my_dir" || exit 1
{
    pigs-init > /dev/null
    pigs-init 
} 2>> "$my_out"

cd "$ref_dir" || exit 1
{
    2041 pigs-init > /dev/null
    2041 pigs-init 
} 2>> "$ref_out"

if diff "$my_out" "$ref_out" > /dev/null
then
    echo "$passed"
else 
    echo "$failed"
fi 
echo ""

: > "$my_out"
: > "$ref_out"

# ===================================================
echo "Error output from: pigs-add"
cd "$my_dir" || exit 1
{
    pigs-add 
    pigs-add a
    pigs-add a b c
    touch a b
    pigs-add a b
    pigs-add a b c
    pigs-add b a c
    pigs-add c a b
} 2>> "$my_out"

cd "$ref_dir" || exit 1
{
    2041 pigs-add 
    2041 pigs-add a
    2041 pigs-add a b c
    2041 touch a b
    2041 pigs-add a b
    2041 pigs-add a b c
    2041 pigs-add b a c
    2041 pigs-add c a b
} 2>> "$ref_out"

if diff "$my_out" "$ref_out" > /dev/null
then
    echo "$passed"
else 
    echo "$failed"
fi 
echo ""

: > "$my_out"
: > "$ref_out"

# ===================================================
echo "Error output from: pigs-commit"
cd "$my_dir" || exit 1
{
    pigs-commit 
    pigs-commit -m -a hi
    pigs-commit -a -m hi hi
    pigs-commit -a hi
    pigs-commit hi
    pigs-commit -a -m
} 2>> "$my_out"

cd "$ref_dir" || exit 1
{
    2041 pigs-commit 
    2041 pigs-commit -m -a hi
    2041 pigs-commit -a -m hi hi
    2041 pigs-commit -a hi
    2041 pigs-commit hi
    2041 pigs-commit -a -m
} 2>> "$ref_out"

if diff "$my_out" "$ref_out" > /dev/null
then
    echo "$passed"
else 
    echo "$failed"
fi 
echo ""

: > "$my_out"
: > "$ref_out"

# ===================================================
echo "Error output from: pigs-log"
cd "$my_dir" || exit 1
{
    pigs-log a
    pigs-log a b 
} 2>> "$my_out"

cd "$ref_dir" || exit 1
{
    2041 pigs-log a
    2041 pigs-log a b
} 2>> "$ref_out"

if diff "$my_out" "$ref_out" > /dev/null
then
    echo "$passed"
else 
    echo "$failed"
fi 
echo ""

: > "$my_out"
: > "$ref_out"

# ===================================================
echo "Error output from: pigs-show"
cd "$my_dir" || exit 1
{
    pigs-show 
    pigs-show a
    pigs-show a b 
    pigs-show a:::::a
    pigs-show :a
} 2>> "$my_out"

cd "$ref_dir" || exit 1
{
    2041 pigs-show 
    2041 pigs-show a
    2041 pigs-show a b 
    2041 pigs-show a:::::a
    2041 pigs-show :a
} 2>> "$ref_out"

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

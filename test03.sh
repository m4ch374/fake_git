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
# Subset 1 - Test errors
# =============================

echo ""
echo "Subset 1 - Test errors"
echo "======================================"

# ===================================================
echo "Commands invoked without .pig"
cd "$my_dir" || exit 1
{
    pigs-rm a
    pigs-rm --force --cached a
    pigs-rm --cached --force a
    pigs-status 
} 2>> "$my_out"

cd "$ref_dir" || exit 1
{
    2041 pigs-rm a
    2041 pigs-rm --force --cached a
    2041 pigs-rm --cached --force a
    2041 pigs-status 
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
echo "Syntax error output on command: pigs-rm"
cd "$my_dir" || exit 1
{
    pigs-init
    pigs-rm 
    pigs-rm --force hi --cached
    pigs-rm --force hi --force
    pigs-rm --lasdfios hi
} >>"$my_out" 2>> "$my_out"

cd "$ref_dir" || exit 1
{
    2041 pigs-init
    2041 pigs-rm 
    2041 pigs-rm --force hi --cached
    2041 pigs-rm --force hi --force
    2041 pigs-rm --lasdfios hi
} >>"$ref_out" 2>> "$ref_out"

if diff "$my_out" "$ref_out" > /dev/null
then
    echo "$passed"
else 
    echo "$failed"

    cat "$my_out"
    echo ""
    cat "$ref_out"
fi 
echo ""

: > "$my_out"
: > "$ref_out"

# ===================================================
echo "Syntax error output on command: pigs-status"
cd "$my_dir" || exit 1
{
    pigs-status hi
    pigs-status hi hi
} >>"$my_out" 2>> "$my_out"

cd "$ref_dir" || exit 1
{
    2041 pigs-status hi
    2041 pigs-status hi hi
} >>"$ref_out" 2>> "$ref_out"

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

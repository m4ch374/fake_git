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
# Subset 2 - Test errors
# =============================

echo ""
echo "Subset 2 - Test errors"
echo "======================================"

# ===================================================
echo "Commands invoked without .pig"
cd "$my_dir" || exit 1
{
    pigs-branch hi
    pigs-branch -d hi
    pigs-checkout hi
    pigs-merge 0 -m merge
    pigs-merge hi -m merge
} 2>> "$my_out"

cd "$ref_dir" || exit 1
{
    2041 pigs-branch hi
    2041 pigs-branch -d hi
    2041 pigs-checkout hi
    2041 pigs-merge 0 -m merge
    2041 pigs-merge hi -m merge
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
echo "Syntax error output on command: pigs-branch"
cd "$my_dir" || exit 1
{
    pigs-init
    pigs-branch 
    pigs-branch -hi
    pigs-branch 12
    pigs-branch hi hi
    pigs-branch master
    pigs-branch -d hi

    touch a
    pigs-add a
    pigs-commit -m a

    pigs-branch 
    pigs-branch -hi
    pigs-branch 12
    pigs-branch hi hi
    pigs-branch master
    pigs-branch -d hi
} >>"$my_out" 2>> "$my_out"

cd "$ref_dir" || exit 1
{
    2041 pigs-init
    2041 pigs-branch 
    2041 pigs-branch -hi
    2041 pigs-branch 12
    2041 pigs-branch hi hi
    2041 pigs-branch master
    2041 pigs-branch -d hi

    touch a
    2041 pigs-add a
    2041 pigs-commit -m a

    2041 pigs-branch 
    2041 pigs-branch -hi
    2041 pigs-branch 12
    2041 pigs-branch hi hi
    2041 pigs-branch master
    2041 pigs-branch -d hi
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

# ===================================================
echo "Syntax error output on command: pigs-checkout"
cd "$my_dir" || exit 1
{
    pigs-checkout 0 
    pigs-checkout lol
    pigs-checkout something
    pigs-checkout master
    pigs-checkout hi hi
    pigs-checkout -dflksdj
} >>"$my_out" 2>> "$my_out"

cd "$ref_dir" || exit 1
{
    2041 pigs-checkout 0 
    2041 pigs-checkout lol
    2041 pigs-checkout something
    2041 pigs-checkout master
    2041 pigs-checkout hi hi
    2041 pigs-checkout -dflksdj
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

# ===================================================
echo "Syntax error output on command: pigs-merge"
cd "$my_dir" || exit 1
{
    pigs-merge 
    pigs-merge -m -m hi
    pigs-merge -m hi
    pigs-merge -sdljfklsd -m hi
    pigs-merge 0 -sdjlfkjsdk hi
    pigs-merge 0 -m -dlskfjklsdfj
    pigs-merge 0 -m 
    pigs-merge 0 -m ""
} >>"$my_out" 2>> "$my_out"

cd "$ref_dir" || exit 1
{
    2041 pigs-merge 
    2041 pigs-merge -m -m hi
    2041 pigs-merge -m hi
    2041 pigs-merge -sdljfklsd -m hi
    2041 pigs-merge 0 -sdjlfkjsdk hi
    2041 pigs-merge 0 -m -dlskfjklsdfj
    2041 pigs-merge 0 -m 
    2041 pigs-merge 0 -m ""
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

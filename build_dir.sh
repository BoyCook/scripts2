#!/bin/bash 
#
#Crowd install shell script
# $Id$

function die() {
     echo $*
     exit 1
}

if [ $# -ne 1 ]
then
    die "Usage: $0 Specify directory-name"
fi

DIRNAME=$1

if [ -d $DIRNAME ]
then
    die "$0: Aborting $DIRNAME already exists"
fi

cd $DIRNAME

mkdir trunk
mkdir branches
mkdir tags

echo "$DIRNAME built"
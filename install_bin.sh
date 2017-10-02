#!/bin/sh

NAME=$1
BIN=$2
DIR=$3
ZIP=$4

if [ $# -ne 4 ]       
then
    echo 'Usage: You must specify [$NAME $BIN $DIR $ZIP]'
    exit 1
fi

if [  ! -f $ZIP ]; then
    echo "File [$ZIP] does not exist"
    exit 1
fi

tar -zxf $ZIP

mv $DIR /usr/share
ln -s /usr/share/$DIR /usr/share/$NAME
ln -s /usr/share/$DIR/bin/$BIN /usr/local/bin/$BIN

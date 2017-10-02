#!/bin/sh

# Notes: 1 - You'll need the script https://collaborate.bt.com/svn/bt-dso/utils/trunk/changenode.rb on your path
#        2 - This assumes that you have a top level BER check out on your file system
#        3 - Param 1 is the current version i.e. 1.5.0
#        4 - Param 2 is the new version i.e. 1.5.1
#        5 - Param 3 is where you have BER checked out on your file system

function die() {
     echo $*
     exit 1
}

if [ $# -ne 5 ]       
then
    die "Usage: $0 Specify current version, new version and directory location"
fi

APP=$1
DIR=$2
V1=$3
V2=$4
ID=$5
SVN='https://collaborate.bt.com/svn/bt-dso'

svn up $DIR/trunk
svn cp $SVN/$APP/trunk $SVN/$APP/tags/$APP-$V1 -m "DSO-334 tagging $APP-$V1 release"
svn up $DIR/tags/$APP-$V1

changenode.rb $DIR/tags/$APP-$V1 pom.xml version $V1-SNAPSHOT $V1
changenode.rb $DIR/tags/$APP-$V1 pom.xml ber.version $V1-SNAPSHOT $V1

svn ci $DIR/tags/$APP-$V1 -m "DSO-334 fixing versions to $V1 in tag FORCE-COMMIT"

changenode.rb $DIR/trunk pom.xml version $V1-SNAPSHOT $V2-SNAPSHOT
changenode.rb $DIR/trunk pom.xml ber.version $V1-SNAPSHOT $V2-SNAPSHOT

svn ci $DIR/trunk -m "$ID incrementing $APP versions in trunk from $V1-SNAPSHOT to $V2-SNAPSHOT"

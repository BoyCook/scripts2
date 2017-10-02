#!/bin/bash 
#
# Office/home config switcher
# $Id find_versions.sh BoyCook $

# DIRS="/var/lib/{application}/releases/*"

function list() {
	echo "Getting all versions..."
	DIRS='/Users/craigcook/temp/*'
	cnt=0
	
	for dir in $DIRS
	do
		if [ -d $dir ]
		then
		 	file=$dir/VERSION.txt
			let cnt=$cnt+1
		
			if [ -f $file ]
			then
				echo "Version $cnt) details are:"
				sed -n '1p;1q' $file
				sed -n '2p;2q' $file
				sed -n '3p;3q' $file						
				echo '-------------------------------------'
			fi		
		fi	
	done
}

list
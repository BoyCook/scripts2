#!/bin/bash 
#
# Will swith profile settings for a user
#
# Mappings are as follows (via symlinks):
# /etc/hosts                 > $SWITCH_PROFILES_DIR/hosts                > $SWITCH_PROFILES_DIR/{profile}/hosts
# $HOME/.gitconfig           > $SWITCH_PROFILES_DIR/.gitconfig           > $SWITCH_PROFILES_DIR/{profile}/.gitconfig
# $HOME/.subversion/servers  > $SWITCH_PROFILES_DIR/.subversion_servers  > $SWITCH_PROFILES_DIR/{profile}/.subversion_servers
# $HOME/.m2/settings.xml     > $SWITCH_PROFILES_DIR/settings.xml         > $SWITCH_PROFILES_DIR/{profile}/settings.xml

SWITCH_PROFILES_DIR="$HOME/.profiles"

function die() {
     echo $*
     exit 1
}

function status() {
  export ENV_STATUS=$*
  echo "Envionment is set as: ($ENV_STATUS)"	
}

function check_dir() {
  if [  ! -d "$1" ]; then
      die "$2"
  fi  
}

function check_file() {
  if [  ! -f "$1" ]; then
    die "$2"
  fi  
}

if [ $# -ne 1 ]
then
    die "Usage: $0 specify profile name or action"
fi

check_dir "$SWITCH_PROFILES_DIR" "Profiles directory [$SWITCH_PROFILES_DIR] does not exist - have you setup your profiles correctly?"

ACTION=$1

if [ "$ACTION" == "SETUP" ] || [ "$ACTION" == "setup" ] 
then
  #TODO do `ln -s` 
  if [  ! -d "$SWITCH_PROFILES_DIR" ]; then
    mkdir $SWITCH_PROFILES_DIR
    die "Created profiles dir [$SWITCH_PROFILES_DIR]"
  fi  
elif [ "$ACTION" == "STATUS" ] || [ "$ACTION" == "status" ]   
then
  echo 'TODO - show current status'
fi  

check_dir "$SWITCH_PROFILES_DIR/$ACTION" "Profile directory [$SWITCH_PROFILES_DIR/$ACTION] does not exist"

  # sudo cp $HOME/bin/scripts/config/hosts_home /etc/hosts
  # sudo cp $HOME/bin/scripts/config/gitconfig_home $HOME/.gitconfig
  # sudo cp $HOME/bin/scripts/config/settings_home.xml $HOME/.m2/settings.xml
  # sudo cp $HOME/bin/scripts/config/servers_home $HOME/.subversion/servers  

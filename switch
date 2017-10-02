#!/bin/bash 
#
# Office/home config switcher
# $Id switch.sh BoyCook $

function die() {
     echo $*
     exit 1
}

function status() {
  export ENV_STATUS=$*
  echo "Envionment is set as: ($ENV_STATUS)"	
}

if [ $# -ne 1 ]
then
    die "Usage: $0 Specify Switch"
fi

SWITCH=$1

case $SWITCH in
'home' | 'on')
  status $SWITCH
  sudo cp $HOME/bin/scripts/config/hosts_home /etc/hosts
  # sudo cp $HOME/bin/scripts/config/gitconfig_home $HOME/.gitconfig
  sudo cp $HOME/bin/scripts/config/settings_home.xml $HOME/.m2/settings.xml
  ;;
'bt' | 'off')
  status $SWITCH
  sudo cp $HOME/bin/scripts/config/hosts_red /etc/hosts
  # sudo cp $HOME/bin/scripts/config/gitconfig_office $HOME/.gitconfig
  sudo cp $HOME/bin/scripts/config/settings_office.xml $HOME/.m2/settings.xml
  ;;
'out' | 'red')
  status $SWITCH
  sudo cp $HOME/bin/scripts/config/hosts_red /etc/hosts
  # sudo cp $HOME/bin/scripts/config/gitconfig_home $HOME/.gitconfig
  sudo cp $HOME/bin/scripts/config/settings_home.xml $HOME/.m2/settings.xml
  ;;
'logica')
  status $SWITCH
  sudo cp $HOME/bin/scripts/config/hosts_red /etc/hosts
  # sudo cp $HOME/bin/scripts/config/gitconfig_home $HOME/.gitconfig
  sudo cp $HOME/bin/scripts/config/settings_logica.xml $HOME/.m2/settings.xml
  ;;
'cccsdown' | 'down')
  status $SWITCH
  sudo cp $HOME/bin/scripts/config/hosts_red /etc/hosts
  # sudo cp $HOME/bin/scripts/config/gitconfig_home $HOME/.gitconfig
  sudo cp $HOME/bin/scripts/config/settings_simple.xml $HOME/.m2/settings.xml
  ;;
'status')
  echo "Envionment is set as: ($ENV_STATUS)"	
  ;;
esac

#  sudo cp $HOME/bin/scripts/config/servers_home $HOME/.subversion/servers

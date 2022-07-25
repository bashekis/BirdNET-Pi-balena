#!/usr/bin/env bash

# Simple new installer
HOME=$HOME
USER=$USER

export HOME=$HOME
export USER=$USER

PACKAGES_MISSING=
for cmd in git jq ; do
  if ! which $cmd &> /dev/null;then
      PACKAGES_MISSING="${PACKAGES_MISSING} $cmd"
  fi
done
if [[ ! -z $PACKAGES_MISSING ]] ; then
  apt update
  apt -y install $PACKAGES_MISSING
fi

branch=main
git clone -b $branch https://github.com/bashekis/BirdNET-Pi-balena.git ${HOME}/BirdNET-Pi &&

$HOME/BirdNET-Pi/scripts/install_birdnet_balena.sh
if [ ${PIPESTATUS[0]} -eq 0 ];then
  echo "Installation completed successfully"
  reboot
else
  echo "The installation exited unsuccessfully."
  exit 1
fi
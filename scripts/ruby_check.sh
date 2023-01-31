#!/bin/bash

REQUIRED_PKG="ruby"
PKG_VERSION="2.7.6"

PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "whereis $REQUIRED_PKG. Installing $REQUIRED_PKG $PKG_VERSION"
  echo "./scripts/main.sh"
fi


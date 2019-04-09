#!/bin/sh
# Purpose
# -------
# Initialize a "working" configuration
#
# Usage
# ------
# Supply the database user and password, the acthome directory, and
# the name of your demo conference in the configuration file
# config.sh, then run this procedure.
#
# Notes
# -----
# The user is no postgres superuser, and can create databases.
# Setting the validity date is a workaround to a known bug in
# pgadmin3
# https://bugs.launchpad.net/ubuntu/+source/pgadmin3/+bug/1480678

. ./config.sh

mkdir --parents $ACTHOME/conf

# You have tpage because you've installed the Perl modules, right?
tpage --define dbuser="$DBUSER" --define dbpass="$DBPASS" \
      --define conference="demo" \
      --define acthome="$ACTHOME" \
      act.ini.tt > $ACTHOME/conf/act.ini
tpage --define acthome="$ACTHOME" actuser="$ACTUSER" \
      conf.act.ini.tt > $ACTHOME/actdocs/demo/conf/act.ini

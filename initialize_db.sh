#!/bin/sh
# Purpose
# -------
# Create the databases for Act and the tables therein
#
# Usage
# ------
# Supply the database user and password and the checkout area
# (without trailing /Act) in the configuration file
# config.sh, then run this procedure.
#
# Notes
# -----
# In a previous step the database user has been configured to
# 'trust', so this procedure can be run from any local user.

. ./config.sh

if [ ! -z "$LOCALE" ]
then export DBLOCALE="--locale=$LOCALE --template=template0"
fi

createdb --username=$DBUSER --encoding=UTF8 --owner=$DBUSER $DBLOCALE act
createdb --username=$DBUSER --encoding=UTF8 --owner=$DBUSER $DBLOCALE acttest
createdb --username=$DBUSER --encoding=UTF8 --owner=$DBUSER $DBLOCALE actwiki

cd $CHECKOUT/Act
bin/dbinit | psql -U $DBUSER act
bin/dbinit | psql -U $DBUSER acttest
wiki-toolkit-setupdb --type postgres --name actwiki --user $DBUSER --pass $DBPASS

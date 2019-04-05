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

createdb --username=$DBUSER --encoding=UTF8 --owner=$DBUSER act
createdb --username=$DBUSER --encoding=UTF8 --owner=$DBUSER acttest
createdb --username=$DBUSER --encoding=UTF8 --owner=$DBUSER actwiki

cd $CHECKOUT/Act
bin/dbinit | psql -U $DBUSER act
bin/dbinit | psql -U $DBUSER acttest
wiki-toolkit-setupdb --type postgres --name actwiki --user $DBUSER --pass $DBPASS
date

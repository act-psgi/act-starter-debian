#!/bin/sh
# Purpose
# -------
# Create a database user as defined in the configuration file.
#
# Usage
# ------
# Supply the database user and password in the configuration file
# config.sh, then run this procedure as the PostgreSQL admin (usually
# postgres)
#
# Notes
# -----
# The user is no postgres superuser, and can create databases.
# Setting the validity date is a workaround to a known bug in
# pgadmin3
# https://bugs.launchpad.net/ubuntu/+source/pgadmin3/+bug/1480678

. ./config.sh

MD5PASS=`perl -MDigest::MD5 -e 'print q(md5) . Digest::MD5::md5_hex($ENV{DBPASS} . $ENV{DBUSER})'`

SQL="CREATE ROLE \"$DBUSER\"
LOGIN ENCRYPTED PASSWORD '$MD5PASS'
CREATEDB
VALID UNTIL '9999-12-31 00:00:00';
COMMENT ON ROLE \"$DBUSER\"
IS 'User id for Act testing';"
echo $SQL | psql

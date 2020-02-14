#!/bin/sh
# Purpose
# -------
# Creates the directory structure for Act.
#
# Usage
# ------
# Supply a repository URL plus branch for Act software and
# the directory for Act data in the configuration file,
# config.sh, then run this procedure.
#
# Notes
# -----
# In this setup, the Act software is kept in a separate location
# from the config file and the wwwdocs / actdocs directories.
# The default templates and the translations are symlinked into
# the ACTHOME directory so the stuff can be kept up to date
# by running git pull.

. ./config.sh

# Fetch the sources
mkdir --parents $CHECKOUT
cd $CHECKOUT
git clone $REPOSITORY
cd Act
git checkout $BRANCH

# Make the data directory
mkdir --parents $ACTHOME

if [ ! -h $ACTHOME/templates ]
then ln --symbolic $CHECKOUT/Act/templates $ACTHOME/templates
fi

if [ ! -h $ACTHOME/po ]
then ln --symbolic $CHECKOUT/Act/po        $ACTHOME/po
fi

if [ ! -h $ACTHOME/wwwdocs ]
then ln --symbolic $CHECKOUT/Act/wwwdocs   $ACTHOME/wwwdocs
fi

mkdir --parents $ACTHOME/photos

# Create the directory for TT compiled templates
mkdir --parents $ACTHOME/var

# Create a conference
mkdir --parents $ACTHOME/actdocs
mkdir --parents $ACTHOME/conferences
mkdir --parents $ACTHOME/conferences/demo
mkdir --parents $ACTHOME/conferences/demo/conf
cp -r $CHECKOUT/Act/skel/actdocs $ACTHOME/conferences/demo/actdocs
cp -r $CHECKOUT/Act/skel/wwwdocs $ACTHOME/conferences/demo/wwwdocs

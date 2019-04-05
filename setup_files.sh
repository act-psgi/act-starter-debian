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
ln --symbolic $CHECKOUT/Act/templates $ACTHOME/templates
ln --symbolic $CHECKOUT/Act/po        $ACTHOME/po
mkdir $ACTHOME/photos

# Create the directory for TT compiled templates
mkdir --parents $ACTHOME/var

# Create a conference
mkdir --parents $ACTHOME/actdocs
mkdir --parents $ACTHOME/wwwdocs
cp -r $CHECKOUT/Act/skel/actdocs $ACTHOME/actdocs/$CONFERENCE
cp -r $CHECKOUT/Act/skel/wwwdocs $ACTHOME/wwwdocs/$CONFERENCE
date

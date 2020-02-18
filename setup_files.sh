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
# the ACT_HOME directory so the stuff can be kept up to date
# by running git pull.

. ./config.sh

# Fetch the sources
mkdir --parents $CHECKOUT
cd $CHECKOUT
git clone $REPOSITORY
cd Act
git checkout $BRANCH

# Make the data directory
mkdir --parents $ACT_HOME

if [ ! -h $ACT_HOME/templates ]
then ln --symbolic $CHECKOUT/Act/templates $ACT_HOME/templates
fi

if [ ! -h $ACT_HOME/po ]
then ln --symbolic $CHECKOUT/Act/po        $ACT_HOME/po
fi

if [ ! -h $ACT_HOME/wwwdocs ]
then ln --symbolic $CHECKOUT/Act/wwwdocs   $ACT_HOME/wwwdocs
fi

mkdir --parents $ACT_HOME/photos

# Create the directory for TT compiled templates
mkdir --parents $ACT_HOME/var

# Create a conference
mkdir --parents $ACT_HOME/actdocs
mkdir --parents $ACT_HOME/conferences
mkdir --parents $ACT_HOME/conferences/demo
mkdir --parents $ACT_HOME/conferences/demo/conf
cp -r $CHECKOUT/Act/skel/actdocs $ACT_HOME/conferences/demo/actdocs
cp -r $CHECKOUT/Act/skel/wwwdocs $ACT_HOME/conferences/demo/wwwdocs

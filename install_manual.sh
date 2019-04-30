#!/bin/sh
# Purpose
# -------
# Installs the Act manual for use by the Act server
#
# Usage
# ------
# The variables ACTHOME and CHECKOUT should already be
# available, so you should be able to just run this procedure.
#
# Notes
# -----
# Per default, the Act documentation will be available under
# http://hostname:5000/manual.  Happy reading!

. ./config.sh

# Make the style sheet available
if [ ! -h $ACTHOME/wwwdocs/mandocs ]
then ln --symbolic $CHECKOUT/Act/mandocs $ACTHOME/wwwdocs/mandocs
fi

# Create - or update - the HTML pages
perl $CHECKOUT/Act/bin/makedoc $ACTHOME/wwwdocs/manual --baseurl /mandocs

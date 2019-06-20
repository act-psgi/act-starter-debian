#!/bin/sh
# Purpose
# -------
# Install (Debian/Ubuntu) packages required by Act
#
# Usage
# ------
# Run this procedure with root privileges
#
# Notes
# -----
# We also pull two Perl distributions as Linux packages:
#  1) cpanminus so that we can use cpanm later
#  2) XML::LibXML because it depends on the version of the
#     GNOME XML Library coming with the system.
# As a side effect, a bunch of Perl dependencies of these
# modules is also pulled from the Linux archives.

apt-get install --quiet --yes git
apt-get install --quiet --yes gcc
apt-get install --quiet --yes make
apt-get install --quiet --yes libgmp-dev
apt-get install --quiet --yes libxml2-dev
apt-get install --quiet --yes libxml-libxml-perl
apt-get install --quiet --yes postgresql
apt-get install --quiet --yes postgresql-server-dev-all
apt-get install --quiet --yes libpng-dev
apt-get install --quiet --yes libjpeg-dev
apt-get install --quiet --yes cpanminus
apt-get install --quiet --yes libexpat1-dev

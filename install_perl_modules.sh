#!/bin/sh
# Purpose
# -------
# Install the Perl modules required by Act
#
# Usage
# ------

# Supply the checkout area (without trailing /Act) in the
# configuration file config.sh, then run this procedure
# either with root privileges for a system wide installation
# or as any user in a perlbrew environment.
#
# Notes
# -----
# The setting CPANM_NOTEST in the configuration file
# can be used to run or suppress the tests run by cpanm-

. ./config.sh

# Find cpanfile
cd $CHECKOUT/Act

# This is ugly, but otherwise XML::Atom won't install because it
# doesn't find its t/TestLib.pm.
export PERL_USE_UNSAFE_INC=1

# This seems to be an undeclared dependency of at keast one of the
# modules we need, so make sure we have it in advance
cpanm Module::Install

# This will now take a while.
cpanm $CPANM_NOTEST --installdeps .

# This isn't a dependency, but we want the tests
cpanm $CPANM_NOTEST Test::Pod

# This is for pulling conferences
cpanm $CPANM_NOTEST Archive::Zip

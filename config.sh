# Where to get the software from
export REPOSITORY=https://github.com/HaraldJoerg/Act.git
export BRANCH=evolution

# The user running the tests.
# Depending on the setup, this might be yourself, 'vagrant' (as on a
# Vagrant Debian box), 'ubuntu' (as on a Vagrant Ubuntu box).
# Don't use $USER: Parts of the scripts run under sudo, where
# $USER will be root.
export ACTUSER=vagrant

# A place for the software.  Git will add /Act to the path.
export CHECKOUT=/home/$ACTUSER/opt

# A place for the data
export ACTHOME=/home/$ACTUSER/var/opt/Act

# Database user (all databases) and password
export DBUSER=act
export DBPASS=act123

# Per default, run cpanm without tests (saves several minutes).
# Comment this out if you want to run the tests.
export CPANM_NOTEST=--notest

# Which conferences to pull
export CONFERENCES=tpc-2018-glasgow

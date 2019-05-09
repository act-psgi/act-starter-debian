# Where to get the software from
export REPOSITORY=https://github.com/HaraldJoerg/Act.git
export BRANCH=stage1

# The user running the tests.

# Depending on the setup, this might be yourself, 'vagrant' (as on a
# Vagrant Debian box), 'ubuntu' (as on a Vagrant Ubuntu box).  Note
# that the procedures running with root privileges will have "root" as
# their value for $USER, so we prevent _overwriting_ an existing value
# for $ACTUSER.
if [ -z "$ACTUSER" ]
then export ACTUSER=$USER
fi

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

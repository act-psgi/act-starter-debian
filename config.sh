# Where to get the software from
export REPOSITORY=https://github.com/act-testing/Act
export BRANCH=master

# The user running the tests.

# Depending on the setup, this might be yourself, 'vagrant' (as on a
# Vagrant Debian box), 'ubuntu' (as on a Vagrant Ubuntu box).  Note
# that the procedures running with root privileges will have "root" as
# their value for $USER, so we prevent _overwriting_ an existing value
# for $ACT_USER.
if [ -z "$ACT_USER" ]
then export ACT_USER=$USER
fi

# A place for the software.  Git will add /Act to the path.
export CHECKOUT=/home/$ACT_USER/opt

# A place for the data
export ACT_HOME=/home/$ACT_USER/var/opt/Act

# Database user (all databases) and password
export DBUSER=act
export DBPASS=act123

# Per default, run cpanm without tests (saves several minutes).
# Comment this out if you want to run the tests.
export CPANM_NOTEST=--notest

# Per default, use packages which are already available
# Gives speedup if you have lots of Perl packages from debian
export CPAMN_SKIP_SATISFIED=--skip-satisfied


# If the system has a default locale of C or POSIX, you need to
# provide a unicode-aware alternative for database sorting.
# Uncomment the next line, or chose your own locale:
#
# export LOCALE=en_US.utf8

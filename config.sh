# Where to get the software from
export REPOSITORY=https://github.com/HaraldJoerg/Act.git
export BRANCH=act-two

# A place for the software.  Git will add /Act to the path.
export CHECKOUT=/home/haj/opt

# A place for the data
export ACTHOME=/home/haj/var/opt/Act

# Database user (all databases) and password
export DBUSER=act
export DBPASS=act123

# Sample conference
export CONFERENCE=demo

# Per default, run cpanm without tests (saves several minutes).
# Comment this out if you want to run the tests.
export CPANM_NOTEST=--notest

#!/bin/sh
# Purpose
# -------
# Create a workable installation of Act from a git checkout
#
# Usage
# ------
# Check config.sh in this directory and adapt the values to your need,
# then run this procedure.  Be aware that many steps require elevated
# privileges and will be invoked with sudo.

. ./config.sh

# Step 1: Get the system up to date
sudo apt-get --yes --quiet update
sudo apt-get --yes --quiet upgrade

# Step 2: Install system modules
sudo -E sh ./install_packages.sh

# Step 3: Fetch Act and create the directory structure
sh ./setup_files.sh

# Step 4: Install the perl libraries (to the system)
sudo -E sh install_perl_modules.sh

# Step 5: Create the act database user
sudo -E -u postgres sh ./create_db_user.sh

# Step 6: Open local PostgreSQL connections for act
sudo -E perl ./patch_pg_hba.pl "$DBUSER"
sudo -E service postgresql restart

# Step 7: Create initial act.ini files
sh ./initialize_config.sh

# Step 8: Create databases and initialize tables
sh ./initialize_db.sh

# Step 9: Install the Act manuals
sh ./install_manual.sh

# From here on, you can:
# - Run a webserver:
#    $ . ./config.sh
#    $ cd $ACTDOCS
#    $ plackup
#
# - Add a conference from https://github.com/Act-Conferences
#    $ . ./config.sh
#    $ perl pull_conferences.pl gpw2019

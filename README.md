# act-starter-debian - From an Act repository to a developer installation

Act [A Conference Toolkit](http://act.mongueurs.net/) is a software to
handle conferences, including talks submissions, talks scheduling,
attendee management, and much more.

Work is under way by several contributors to modernize the software.

For me, one of the obstacles to contribute was that it isn't that easy
to get from a checkout to a developer installation to work with.

This small set of procedures is supposed to run on either a freshly
created Debian system, or a Vagrant debian box, to create an
installation which allows to hack on Act and to inspect the results
on your own development machine.

Installations created in this way are _not_ meant for production!

## How to use

1. Change into the directory of the checkout 
2. Inspect the file config.sh: It sets the parameters which will be
   used throughout the further steps.  You might want to change
   the values of CHECKOUT and ACTHOME if you are not running a
   debian/stretch64 vagrant box.

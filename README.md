# act-starter-debian - From an Act repository to a developer installation

Act ([A Conference Toolkit](http://act.mongueurs.net/)) is a software
to handle conferences, including talks submissions, talks scheduling,
attendee management, and much more.

Work is under way by several contributors to modernize the software.

For me, one of the obstacles to contribute was that it isn't that easy
to get from a checkout to a developer installation to work with.

This small set of procedures is supposed to run on either a freshly
created Debian system, or a Vagrant debian box, to create an
installation which allows to hack on Act and to inspect the results
on your own development machine.

I intend to keep it in synch with the active branches (right now:
evolution) in my fork of Act at https://github.com/HaraldJoerg/Act.
It may work with other forks, too.

Installations created in this way are _not_ meant for production!

## How to use

1. Change into the directory of the checkout of act-starter-debian.
2. Inspect the file config.sh: It sets the parameters which will be
   used throughout the further steps.  You might want to change
   the values of CHECKOUT and ACTHOME if you are not running a
   debian/stretch64 vagrant box.
3. For the adventurous: `sh developer_install.sh`.  *Caution:* Some of
   the procedures use sudo for root privileges - vagrant boxes come
   with passwordless sudo for the user `vagrant`.
4. For the conservative: Inspect the procedures called by
   developer_install.sh, and call them one by one.

When the procedure is done without errors:
1. Setup your own environment: `. ./config.sh`
2. Change to the Act checkout directory and run `prove -lv`.
3. Enjoy.

When the testsuite passes, run from the same directory:

  `plackup -Ilib app.psgi`

and point a browser to http://localhost:5000/demo. (or whatever you've
configured as the name for your conference).

Have fun!

## Known issues

* Yet to be investigated: The _first_ run of `t/04template.t` fails at
  test number 12.  Run the same test again - and it passes.  Weird,
  isn't it?
* The fact that the testsuite passes doesn't imply that the
  installation actually works.  If it doesn't, then this indicates
  that a) the installation doesn't work, and b) the tests might need
  to be extended.

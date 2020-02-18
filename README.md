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
stage0) in my fork of Act at https://github.com/act-psgi/Act.
It may work with other forks, too, but chances are getting worse
while Act is carried forward.

Installations created in this way are _not_ meant for production!

## How to use

1. Change into the directory of the checkout of act-starter-debian.
2. Inspect the file config.sh: It sets the parameters which will be
   used throughout the further steps.  You might want to change
   the values of CHECKOUT and ACT_HOME if you are not running a
   debian/stretch64 vagrant box.
3. For the adventurous: `sh developer_install.sh`.  *Caution:* Some of
   the procedures use sudo for root privileges - vagrant boxes come
   with passwordless sudo for the user `vagrant`.
4. For the conservative: Inspect the procedures called by
   developer_install.sh, and call them one by one.

When the procedure is done without errors:
1. Setup your own environment: `. ./config.sh`
2. Change to the Act checkout directory
3. Run `prove -lv`.
3. Enjoy.

When the testsuite passes, run from the same directory:

  `plackup --access-log=/tmp/access-log`

and point a browser to http://localhost:5000/demo. (or whatever you've
configured as the name for your conference).

The Act manual, updated for this fork, is available at
http://localhost:5000/manual/Manual.html.

_Note:_ There is just a default "not found" page behind the "homepage"
http://localhost:5000/ advertised by plackup after its startup.

Have fun!

## Importing other conferences

The repository also contains a Perl program which allows to import
conference data from https://github.com/Act-Conferences like this:

  `perl pull-conferences.pl tpc-2018-glasgow`

Note that this is just importing a snapshot (a git archive), not
cloning the repository.  So you can't damage existing conferences by
accidentally typing `git push` into the wrong xterm.

You then need to add the imported conference to
`~/var/opt/Act/conf/act.ini`.  Add it to the second line like this:

   `conferences = demo tpc-2018-glasgow`

Then restart the web server and you can see the content from the
Glasgow conference at http://localhost:5000/tpc-2018-glasgow.  Of
course, the database is missing, so there's no schedule, no users, no
wiki, etc.

## Updating the HTML view of the Act manual

After updating the Act software which includes the manual, the HTML
view of the manual can be re-created by changing into this package's
directory and running

   `sh install_manual.sh`

## Known issues

* You need to `cd` into their directory for these procedures to work.
* The fact that the testsuite passes doesn't imply that the
  installation actually works.  If it doesn't, then this indicates
  that a) the installation doesn't work, and b) the tests might need
  to be extended.

## Setup the rest of the system

If you want to run a proper ACT instance, you will need to add a few more
things

### DNS

Point a DNS entry to your server

### Init system: system.d

Take a look at `example/systemd/act_psgi.service`, adapt the paths to your
setup and copy the file to `/etc/systemd/system/act_psgi.service`

* `systemd daemon-reload`
* `systemctl start act_psgi`
* `systemctl enable act_psgi`

### Frontend proxy: nginx

`apt install nginx`

Take a look at `example/nginx/your-act.example.com.conf`, adapt `server_name`
and copy the file to `/etc/nginx/your-act.example.com.conf` on your host.

Restart nginx: `systemd nginx restart`

#### https

* `apt-get install certbot python-certbot-nginx`
* `certbot --nginx`
* Answer all the questions, defaults should be fine
* `systemctl restart nginx`
* See `example/nginx/your-act.example.com-ssl.conf`

### Mailer: exim

TODO

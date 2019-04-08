#!/usr/bin/env perl
# ABSTRACT: Patch PostgreSQL authentication config
# Purpose
# -------
# Allow local users to impersonate the Act database user without
# authentication
#
# Usage
# ------
# Supply the database user in the configuration file config.sh, then
# run this procedure with root privileges.
#
# Notes
# -----
# Running the procedure multiple times will insert two lines into the
# configuration file each time.  This is harmless but annoying,
# therefore listed as a TODO.
use 5.020;
use File::Find;
use File::Copy;
use File::Temp qw(tempfile);

my $directory = '/etc/postgresql';
my $target    = 'pg_hba.conf';
my $dbuser    = shift // $ENV{DBUSER}
    or die "Please provide the database user as an argument\n",
           "or as environment variable DBUSER.\n",
    "Terminating.\n";

# Part 1: Find the config file to be patched.
# PostgreSQL stores it depending on the version
# as e.g. /etc/postgresql/9.6/main/pg_hba.conf
my @candidates;

sub found {
    push @candidates,$File::Find::name if $_ eq $target;
}

find(\&found,$directory);

if (! @candidates) {
    die "No file '$target' found in '$directory'.  Terminating.\n";
}

# Bail out if there's more than one file (i.e. more than one
# PostgreSQL version) on this system
if (scalar @candidates > 1) {
    die "Ambiguous targets:  We found \n  ",
        join("\n  ",@candidates),"\n",
        "Terminating.\n";
}

my $file = shift @candidates;

# Part 2: Patch the file, making a backup copy first
my $backup_file = "${file}.bak";
copy($file,$backup_file)
    or die "Failed to create a backup file: '$!'\n";

my ($fh,$tempfile) = tempfile();

my $replacement_succeeded = 0;

open (my $in,'<',$file)
    or die "Failed to read the config file: '$!'\n";
while (<$in>) {
    if (/(local\s+all\s+)(all\s+)peer/) {
        my $prefix = $1;
        my $users  = $2;
        substr($users,0,length $dbuser,$dbuser);
        print $fh "# trust for '$dbuser' added by Act config\n";
        print $fh "${prefix}${users}trust\n";
        $replacement_succeeded++;
    }
    print $fh $_;
}

if ($replacement_succeeded == 1) {
    move($tempfile,$file)
        or do {
            unlink $backup_file;
            die "Failed to write the config file back: '$!'\n";
        };
    my (undef,undef,$uid,$gid) = getpwnam('postgres');
    $uid && $gid && chown($uid,$gid,$file)
        or die "Failed to change ownership of '$file'\n",
        "to the PostgreSQL super user.  Please do it yourself.\n";
}
else {
    unlink $backup_file;
    die "Failed to patch the config file.\n";
}

# TODO: Detect whether the file has already been patched.

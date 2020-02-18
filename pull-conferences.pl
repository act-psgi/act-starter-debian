#!/usr/bin/env perl
# ABSTRACT: Load a list of Act conferences from GitHub
# Purpose
# -------
# Show different conferences as required by testers
#
# Usage
# ------
# Supply the list of conferences in the configuration file config.sh,
# then run this procedure.
#
# Notes
# -----
# Contrary to the name of this procedure, it does _not_ do a git pull
# nor git clone of the repository.  This test software is not meant to
# make changes to existing conferences at its current stage.

use 5.020;

use File::Temp qw(tempdir);
use LWP::Simple qw(getstore);
use Archive::Zip qw(:ERROR_CODES);

my $tempdir = tempdir();

my $url_prefix = 'https://github.com/Act-Conferences';
my $branch     = 'production';
my $url_suffix = "archive/${branch}.zip";

my $act_home   = $ENV{ACT_HOME};


my @conferences = @ARGV;
CONFERENCE:
for my $conference (@conferences) {
    my $filename = "$tempdir/${conference}.zip";
    my $url      = "$url_prefix/$conference/$url_suffix";
    my $result   = getstore($url,$filename);
    if ($result ne '200') {
        warn "Warning: Failed to import the conference '$conference'\n";
        next CONFERENCE;
    }

    my $zip = Archive::Zip->new;
    unless ( $zip->read( $filename ) == AZ_OK ) {
        warn "Warning: Failed to unpack '$filename'\n";
        next CONFERENCE;
    }

    my $root = "${conference}-${branch}";
    $zip->extractTree("$root/actdocs","$act_home/conferences/$conference/actdocs");
    $zip->extractTree("$root/wwwdocs","$act_home/conferences/$conference/wwwdocs");
}

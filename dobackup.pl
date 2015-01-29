#!/usr/bin/perl -w
# released under the GPL on 2004-09-06 - written by lithron@gmail.com
# http://www.lithron.com
# "dobackup.pl" version 0.04

# this program requires File::Glob and Config::Tiny from CPAN

use strict;
use File::Glob qw(bsd_glob);
use Config::Tiny;

##### Configure these variables for your system #####

my $DEBUGLEVEL=0;

# where do you keep tar?
my $TAREXE = "/usr/bin/tar";
my $BACKUPDIR = "backups";
my $LOGFILE = "$BACKUPDIR/backup.log";
my $ERRORREDIR = "2>>$LOGFILE";
my $EXT = ".tar";

# what compression program do you want to use?  what flags?
my $COMPRESSEXE = "/usr/bin/bzip2 -f -s -1";
# my $COMPRESSEXE = "/usr/bin/gzip -f -9";
# my $COMPRESSEXE = "";   # if you don't want compression at all, use this.

# if you want to use the 'zip' program to create the entire
# archive, then use the entries below:
# my $TAREXE = "/usr/bin/zip -r -9";
# my $COMPRESSEXE = "";
# my $EXT = ".zip";


################ END OF USER CONFIGURABLE VARIABLES ########################


my @configfiles = bsd_glob("directories/*.ini");

system("rm $BACKUPDIR/* 2>/dev/null");

foreach (@configfiles) { 
  my $configfile = $_;
  my $Config = Config::Tiny->read("$_");
  my $name = $Config->{_}->{name};
  my $tarcmd = $Config->{_}->{tarcmd};
  my $filename = $Config->{_}->{filename};
  my $dir = $Config->{_}->{dir};
  my $log = $Config->{_}->{log};
  my $compress = $Config->{_}->{compress};
 
  print "[$configfile] executing $name script now\n";
  my $execstring = "$TAREXE $tarcmd -cvf \"$BACKUPDIR/$filename$EXT\" \"$dir\"";
  $execstring .= " >> $LOGFILE" if ($LOGFILE ne ""); 
  $execstring .= " $ERRORREDIR" if ($ERRORREDIR ne "");
  print("[$configfile] $execstring\n") if $DEBUGLEVEL > 0; 
  system($execstring);
  print "[$configfile] finished $name script\n";
  if ((($compress eq "yes") or ($compress eq "YES")) and ($COMPRESSEXE ne "")) {
    print "[$configfile] Starting compression now...\n";
    system("$COMPRESSEXE \"$BACKUPDIR/$filename.tar\"") if ($COMPRESSEXE ne "");
    print "[$configfile] finished compressing...\n";
    }
  print "NEXT!\n";
  }




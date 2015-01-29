# dobackup
Perl script to separate files by CD/DVD size for easy backups

"dobackup.pl" version 0.04 is a Perl based backup system

Its strength lies in its simplicity, and ability to be changed for specific situations.  All it requires is Perl, File::Glob, Config::Tiny, a text editor tar, and a compression program.


INSTALLATION
------------
* Make sure your perl binary is setup and working.  'perl -V' at the command 
  line should show you the version number, along with all of the configuration
  information about your perl binary.  

* Install File::Glob and Config::Tiny from http://www.cpan.org
  If you have CPAN installed properly, you can run 
  'cpan File::Glob Config::Tiny' and CPAN will install them for you.

* Edit the dobackup.pl file to reflect the paths for your tar and compression
  binaries.  Notice that you can use 'zip' or 'pkzip'-like programs.


SETUP
-----
Edit the "directories/*.ini" files and crate an .ini file for every separate directory you want backed up.  Keep in mind that you can choose to do recursive backups into subdirectories, so you may only need to setup a handful of these.  The "directories/test.ini" that is included with the package is heavily commented, so you may wish to read through it for instructions on how to set an .ini file up.


RUNNING
------- 
You can run dobackup.pl any time you want, although you don't want more than one instance running at once.  I suggest timing the backup the first time you run it, so you'll know approx. how long it will take in the future.  If you wish to setup a cron script that runs it, give it at least twice the amount of time that you timed from above.

You can invoke it with:<br>
```
# perl dobackup.pl<br>
```
and it will run based on the configuration files in directories/*.ini and it will output its status to the screen every time it starts or stops a script.


TODO
----
* MD5 sums?
* Cryptographic signing? GPG?
* interface to mkisofs and cdrecord?
* comments in the 63 line source file..
* suggestions to this list welcomed.


AUTHOR
------
lithron@gmail.com

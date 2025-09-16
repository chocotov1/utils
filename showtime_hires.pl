#!/usr/bin/perl -w

$| = 1;
use POSIX; 
use Time::HiRes qw(gettimeofday);

$SIG{INT} = sub {
   print "\x1b[?25h"; # show cursor again before exiting
   print "\n";
   exit 0;
};

print "\x1b[?25l"; # hide the cursor


while(1){
   my ($time_epoch, $ms) = gettimeofday();
   printf("\r%s.%03d", strftime("%F %T", localtime($time_epoch)), $ms / 1000);

   select(undef,undef,undef,0.025);
}

#!/usr/bin/perl -w

$| = 1;
use POSIX; 

$SIG{INT} = sub {
   print "\x1b[?25h"; # show cursor again before exiting
   print "\n";
   exit 0;
};

print "\x1b[?25l"; # hide the cursor

while(1){
   printf("\r%s", strftime("%F %T", localtime));
   select(undef,undef,undef,0.1);
}

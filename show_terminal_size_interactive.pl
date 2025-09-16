#!/usr/bin/perl -w

$| = 1;
use POSIX; 
use Term::ReadKey;

my $verbose = 0;
$verbose++ if (defined($ARGV[0]) && $ARGV[0] eq "-v"); 

$SIG{INT} = sub {
   restore_terminal();
   exit 0;
};

$SIG{WINCH} = sub {
   show_terminal_size();
};

initialize_terminal();

if ($verbose){
   print "showing interactive terminal size, updated on change\n";
}

show_terminal_size();

# keep program open until key is pressed
ReadKey();

restore_terminal();

sub show_terminal_size {
   my ($wchar, $hchar, $wpixels, $hpixels) = GetTerminalSize();

   if ($verbose){
      printf("\r%dx%d ... press any key to exit  ", $wchar, $hchar);
   } else {
      printf("\r%dx%d  ", $wchar, $hchar);
   }
}

sub initialize_terminal {
   print "\x1b[?25l"; # hide the cursor
 
   # enable single key press detection of Term::ReadKey
   # needs to be restored on exit to maintain functional terminal
   ReadMode('cbreak');
}

sub restore_terminal {
   ReadMode('restore');
   print "\n";
   print "\x1b[?25h"; # show cursor again
}

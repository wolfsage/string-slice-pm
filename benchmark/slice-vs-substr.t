use strict;
use warnings;

use Benchmark qw(timethese);
use Devel::Peek;
use String::Slice;

timethese(1, {

  'substr' => sub {
    my $x = 'x' x 1024 x 200;
    my $sub = 'x' x 10;

    # Grab 10 chars at a time
    for (my $i = 0; $i < length($x) - 10; $i += 10) {
      if (substr($x, $i, 10) ne $sub) {
        die "Got bad data! Expected '$sub', got " . substr($x, $i, 10) . "\n";
      }
    }
  },

  'string::slice' => sub {
    my $slice = '';
    my $x = 'x' x 1024 x 200;
    my $sub = 'x' x 10;

    # Grab 10 chars at a time
    for (my $i = 0; $i < length($x) - 10; $i += 10) {
      unless (slice($slice, $x, $i, 10)) {
        die "Failed to slice at position $i\n";
      }
      if ($slice ne $sub) {
        die "Got bad data! Expected '$sub', got $slice\n";
      }
    }
  },

});



#!/usr/bin/env perl

use strict;
use warnings;

my $expr = @ARGV ? join ' ', @ARGV : do { local $/; <STDIN> };
$expr =~ s/^\s+|\s+$//g;

my $out = eval($expr);
if ($expr =~ /0[xX]/) {
    printf "0x%x", $out;
} else {
    print $out
}

if ($@) {
    warn "$@";
    exit 1;
}

#!/usr/bin/env perl

use v5.18;

use Getopt::Std;

getopts 've', \my %opt;
my $pfx;
$pfx = 'PAD_CTL_' if $opt{v};

while (my $n = <>) {
    $n =~ s/_//g;
    $n =~ s/(.+)h/0x$1/g;
    $n = oct($n) if $n =~ /^0/;
    printf "0x%x:\n", $n if ($opt{e});

    my %pinfunc = imx6q_pinfunc($n);
    say "\t${pfx}HYS"           if (($n >> 16) & 1) == 1;
    if ((($n >> 12) & 1) == 1) {
        say "\t${pfx}PKE";
        say "\t\t${pfx}PUE (Keep)" if (($n >> 13) & 1) == 0;
        if ((($n >> 13) & 1) == 1) {
            say "\t\t${pfx}PUE (Pull)";

            say "\t\t\t${pfx}PUS_100K_DOWN" if (($n >> 14) & 3) == 0;
            say "\t\t\t${pfx}PUS_47K_UP"    if (($n >> 14) & 3) == 1;
            say "\t\t\t${pfx}PUS_100K_UP"   if (($n >> 14) & 3) == 2;
            say "\t\t\t${pfx}PUS_22K_UP"    if (($n >> 14) & 3) == 3;
        }
    }
    say "\t${pfx}ODE (OpenDrain)"           if (($n >> 11) & 1) == 1;
    say "\t${pfx}SPEED_MED (100MHz)"     if (($n >> 6)  & 3) == 1;
    say "\t${pfx}SPEED_MED (100MHz 2)"     if (($n >> 6)  & 3) == 2;
    if ((($n >> 0)  & 1) == 1) {
        say "\t${pfx}SPEED_HIGH (150 MHz)"    if (($n >> 6)  & 3) == 3;
    } else {
        say "\t${pfx}SPEED_HIGH (100 MHz)"    if (($n >> 6)  & 3) == 3;
    }
    say "\t${pfx}DSE_HI-Z"      if (($n >> 3)  & 7) == 1;
    say "\t${pfx}DSE_240ohm"    if (($n >> 3)  & 7) == 1;
    say "\t${pfx}DSE_120ohm"    if (($n >> 3)  & 7) == 2;
    say "\t${pfx}DSE_80ohm"     if (($n >> 3)  & 7) == 3;
    say "\t${pfx}DSE_60ohm"     if (($n >> 3)  & 7) == 4;
    say "\t${pfx}DSE_48ohm"     if (($n >> 3)  & 7) == 5;
    say "\t${pfx}DSE_40ohm"     if (($n >> 3)  & 7) == 6;
    say "\t${pfx}DSE_34ohm"     if (($n >> 3)  & 7) == 7;
    say "\t${pfx}SRE_FAST"      if (($n >> 0)  & 1) == 1;
}

sub imx6q_pinfunc {
    my %pinfunc;
    $pinfunc{hys} = (($n >> 16) & 1) == 1;
    if ((($n >> 12) & 1) == 1) {
        if ((($n >> 13) & 1) == 1) {
            $pinfunc{pue} = ($n >> 14) & 3;


            $pinfunc{pue} = "100K DOWN" if $pinfunc{pue} == 0;
            $pinfunc{pue} = "47K UP"    if $pinfunc{pue} == 1;
            $pinfunc{pue} = "100K UP"   if $pinfunc{pue} == 2;
            $pinfunc{pue} = "22K UP"    if $pinfunc{pue} == 3;
        } else {
            $pinfunc{pke} = 1;
        }
        $punfunc{pue} = (($n >> 13) & 1) == 1;
    }
    say "\t${pfx}ODE (OpenDrain)"           if (($n >> 11) & 1) == 1;
    say "\t${pfx}SPEED_MED (100MHz)"     if (($n >> 6)  & 3) == 1;
    say "\t${pfx}SPEED_MED (100MHz 2)"     if (($n >> 6)  & 3) == 2;
    if ((($n >> 0)  & 1) == 1) {
        say "\t${pfx}SPEED_HIGH (150 MHz)"    if (($n >> 6)  & 3) == 3;
    } else {
        say "\t${pfx}SPEED_HIGH (100 MHz)"    if (($n >> 6)  & 3) == 3;
    }
    say "\t${pfx}DSE_HI-Z"      if (($n >> 3)  & 7) == 1;
    say "\t${pfx}DSE_240ohm"    if (($n >> 3)  & 7) == 1;
    say "\t${pfx}DSE_120ohm"    if (($n >> 3)  & 7) == 2;
    say "\t${pfx}DSE_80ohm"     if (($n >> 3)  & 7) == 3;
    say "\t${pfx}DSE_60ohm"     if (($n >> 3)  & 7) == 4;
    say "\t${pfx}DSE_48ohm"     if (($n >> 3)  & 7) == 5;
    say "\t${pfx}DSE_40ohm"     if (($n >> 3)  & 7) == 6;
    say "\t${pfx}DSE_34ohm"     if (($n >> 3)  & 7) == 7;
    say "\t${pfx}SRE_FAST"      if (($n >> 0)  & 1) == 1;
}
__END__

my %shifts;

while (my $def = <DATA>) {
if (/^(PAD_\w+)\s+\(\s*(.*)\s*<<\s*(.*)\s*\)$/) {
my ($pad, $val, $shift) = ($1, $2, $3);
$shifts{$shift} //= [];
push @{$shifts{$shift}}, [$val, $pad];
}
}

while (my ($shift, $vals) = each %shifts) {
sort @$vals;
}



while (my $num = <>) {
my %imx6ul_pads = (
0     => "PAD_CTL_DSE_DISABLE" |    => "PAD_CTL_PUS_100K_DOWN",
0     => "PAD_CTL_SPEED_LOW",
0     => "PAD_CTL_SRE_SLOW",
1     => "PAD_CTL_SRE_FAST",
8     => "PAD_CTL_DSE_260ohm",
16    => "PAD_CTL_DSE_130ohm",
24    => "PAD_CTL_DSE_87ohm",
32    => "PAD_CTL_DSE_65ohm",
40    => "PAD_CTL_DSE_52ohm",
48    => "PAD_CTL_DSE_43ohm",
56    => "PAD_CTL_DSE_37ohm",
64    => "PAD_CTL_SPEED_MED",
192   => "PAD_CTL_SPEED_HIGH",
2048  => "PAD_CTL_ODE",
4096  => "PAD_CTL_PKE",
8192  => "PAD_CTL_PUE",
16384 => "PAD_CTL_PUS_47K_UP",
32768 => "PAD_CTL_PUS_100K_UP",
49152 => "PAD_CTL_PUS_22K_UP",
65536 => "PAD_CTL_HYS",
);
$num = oct($num) if $num =~ /^0/;
while (my ($k, $v) = each %imx6ul_pads) {
print "$num, $k";
print " => $v |\n" if ($num & $k) == $k;
print "\n";
}
}
__DATA__
PAD_CTL_HYS                     (1 << 16)
PAD_CTL_PUS_100K_DOWN           (0 << 14)
PAD_CTL_PUS_47K_UP              (1 << 14)
PAD_CTL_PUS_100K_UP             (2 << 14)
PAD_CTL_PUS_22K_UP              (3 << 14)
PAD_CTL_PUE                     (1 << 13)
PAD_CTL_PKE                     (1 << 12)
PAD_CTL_ODE                     (1 << 11)
PAD_CTL_SPEED_LOW               (0 << 6)
PAD_CTL_SPEED_MED               (1 << 6)
PAD_CTL_SPEED_HIGH              (3 << 6)
PAD_CTL_DSE_DISABLE             (0 << 3)
PAD_CTL_DSE_260ohm              (1 << 3)
PAD_CTL_DSE_130ohm              (2 << 3)
PAD_CTL_DSE_87ohm               (3 << 3)
PAD_CTL_DSE_65ohm               (4 << 3)
PAD_CTL_DSE_52ohm               (5 << 3)
PAD_CTL_DSE_43ohm               (6 << 3)
PAD_CTL_DSE_37ohm               (7 << 3)
PAD_CTL_SRE_FAST                (1 << 0)
PAD_CTL_SRE_SLOW                (0 << 0)


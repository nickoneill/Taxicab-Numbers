#!/usr/bin/perl -w
# brute forcing sums of exponents
# nick o'neill - nick.oneill@gmail.com - http://www.raquo.net/fine-structure/
#
# Configuration:
#   @terms is the set of possible numbers to exponent
#   @exponents is the set of exponents to use on the numbers
#   @termcounts is the set of term numbers to use
#
#   %sums will be filled with every sum generated, counts for how many times the sum was generated,
#   which numbers generated the sum and which exponent was used
#
#   %sums:
#       $sums{1729}{count} = 2
#       $sums{1729}{by} = [1, 12, 9, 10]
#       $sums{1729}{exponent} = [3, 3]
#
#   Default configuration cubes numbers between 1 and 12 and adds each combination, displaying only the pairs of numbers that have non-unique results. This configuration is specifically tuned to generate the "taxicab number", 1729 <http://en.wikipedia.org/wiki/Taxicab_number>, however, it can be modified simply to generate other taxicab-like numbers with different exponents or numbers of terms (the taxicab number, for example, has an exponent of 3 and 2 terms).
#
#
# Use:
#   Just Fucking Run It
#

use strict;
use Math::Combinatorics;

my @terms = (1..12);
my @exponents = (3..3);
my @termcounts = (2..2);

foreach my $exponent (@exponents) {
    foreach my $termcount (@termcounts) {
        my %sums;
        my @combines = combine($termcount,@terms);
        
        foreach my $combinations (@combines) {
            my $sum = 0;
            foreach my $number (@{$combinations}) {
                $sum = $sum + ($number ** $exponent);
            }
            $sums{$sum}{count}++;
            push (@{$sums{$sum}{exponent}}, $exponent);
            foreach my $number (@{$combinations}) {
                push (@{$sums{$sum}{by}}, $number);
            }
        }
        
        foreach my $sum (keys %sums) {
            if ($sums{$sum}{count} >= 2) {
                print "$sum generated ".$sums{$sum}{count}." times by";
                my $i = 0;
                foreach my $number (@{$sums{$sum}{by}}) {
                    print " $number^".@{$sums{$sum}{exponent}}[0];
                    print "," if ($i % $termcount) == ($termcount - 1);
                    $i++;
                }
                print "\n";
            }
        }
    }
}

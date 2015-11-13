package Bencher::Scenario::SetOperationModules;

# DATE
# VERSION

use 5.010001;
use strict;
use utf8;
use warnings;

our $scenario = {
    participants => [
        {
            tags => ['op:union'],
            module => 'Array::Utils',
            function => 'unique',
            code_template => '&Array::Utils::unique(<set1>, <set2>)', # we use &func instead of func to defeat prototype which confuses some tools
        },
        {
            tags => ['op:union'],
            module => 'Set::Scalar',
            function => 'union',
            code_template => 'my $s1 = Set::Scalar->new(@{<set1>}); my $s2 = Set::Scalar->new(@{<set2>}); $s1->union($s2)',
        },
        {
            tags => ['op:union'],
            fcall_template => 'List::MoreUtils::PP::uniq(@{<set1>}, @{<set2>})',
        },
        {
            name => 'List::MoreUtils::XS::uniq',
            tags => ['op:union'],
            module => 'List::MoreUtils::XS',
            fcall_template => 'List::MoreUtils::uniq(@{<set1>}, @{<set2>})',
        },
        {
            tags => ['op:union'],
            fcall_template => 'Array::Set::set_union(<set1>, <set2>)',
        },

        {
            tags => ['op:symdiff'],
            module => 'Array::Utils',
            function => 'array_diff',
            code_template => '&Array::Utils::array_diff(<set1>, <set2>)', # we use &func instead of func to defeat prototype which confuses some tools
        },
        {
            tags => ['op:symdiff'],
            module => 'Set::Scalar',
            function => 'symmetric_difference',
            code_template => 'my $s1 = Set::Scalar->new(@{<set1>}); my $s2 = Set::Scalar->new(@{<set2>}); $s1->symmetric_difference($s2)',
        },
        # List::MoreUtils' singleton() can do symmetric difference as long as we
        # make sure that set1 and set2 do not contain duplicates (which, since
        # they should be sets, should not)
        {
            tags => ['op:symdiff'],
            fcall_template => 'List::MoreUtils::PP::singleton(@{<set1>}, @{<set2>})',
        },
        {
            name => 'List::MoreUtils::XS::singleton',
            tags => ['op:symdiff'],
            module => 'List::MoreUtils::XS',
            fcall_template => 'List::MoreUtils::singleton(@{<set1>}, @{<set2>})',
        },
        {
            tags => ['op:symdiff'],
            fcall_template => 'Array::Set::set_symdiff(<set1>, <set2>)',
        },

        {
            tags => ['op:diff'],
            module => 'Array::Utils',
            function => 'array_minus',
            code_template => '&Array::Utils::array_minus(<set1>, <set2>)', # we use &func instead of func to defeat prototype which confuses some tools
        },
        {
            tags => ['op:diff'],
            module => 'Set::Scalar',
            function => 'difference',
            code_template => 'my $s1 = Set::Scalar->new(@{<set1>}); my $s2 = Set::Scalar->new(@{<set2>}); $s1->difference($s2)',
        },
        {
            tags => ['op:diff'],
            fcall_template => 'Array::Set::set_diff(<set1>, <set2>)',
        },

        {
            tags => ['op:intersect'],
            module => 'Array::Utils',
            function => 'intersect',
            code_template => '&Array::Utils::intersect(<set1>, <set2>)', # we use &func instead of func to defeat prototype which confuses some tools
        },
        {
            tags => ['op:intersect'],
            module => 'Set::Scalar',
            function => 'intersection',
            code_template => 'my $s1 = Set::Scalar->new(@{<set1>}); my $s2 = Set::Scalar->new(@{<set2>}); $s1->intersection($s2)',
        },
        # there's no opposite for singleton() yet in List::MoreUtils (as of
        # v0.413).
        {
            tags => ['op:intersect'],
            fcall_template => 'Array::Set::set_intersect(<set1>, <set2>)',
        },
    ],

    # XXX: add more datasets (larger data, etc)
    datasets => [
        {
            name => 'num10',
            args => {
                set1 => [1..10],
                set2 => [2..11],
            },
        },
        {
            name => 'num100',
            args => {
                set1 => [1..100],
                set2 => [2..101],
            },
        },
        {
            name => 'num1000',
            args => {
                set1 => [1..1000],
                set2 => [2..1001],
            },
            include_by_default => 0,
        },
    ],
};

1;
# ABSTRACT: Benchmark Perl set operation (union, intersection, diff, symmetric diff) modules

=head1 SYNOPSIS

 % bencher -m SetOperationModules [other options]...

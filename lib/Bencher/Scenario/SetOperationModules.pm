package Bencher::Scenario::SetOperationModules;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

our $scenario = {
    summary => 'Benchmark Perl set operation (union, intersection, diff, symmetric diff) modules',
    modules => {
        'List::MoreUtils' => {
            version => '0.407', # singleton() is available from this version
        },
    },
    participants => [
        # UNION
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
            tags => ['op:union'],
            module => 'Set::Array',
            function => 'union',
            code_template => 'my $s1 = Set::Array->new(@{<set1>}); my $s2 = Set::Array->new(@{<set2>}); $s1->union($s2)',
        },
        {
            tags => ['op:union'],
            module => 'Array::AsObject',
            function => 'union',
            code_template => 'my $s1 = Array::AsObject->new(@{<set1>}); my $s2 = Array::AsObject->new(@{<set2>}); $s1->union($s2, 1)',
        },
        {
            tags => ['op:union'],
            module => 'Set::Object',
            function => 'union',
            code_template => 'my $s1 = Set::Object->new(@{<set1>}); my $s2 = Set::Object->new(@{<set2>}); $s1->union($s2)',
        },
        {
            tags => ['op:union'],
            module => 'Set::Tiny',
            function => 'union',
            code_template => 'my $s1 = Set::Tiny->new(@{<set1>}); my $s2 = Set::Tiny->new(@{<set2>}); $s1->union($s2)',
        },
        {
            tags => ['op:union'],
            module => 'List::Collection',
            function => 'union',
            code_template => '[List::Collection::union(<set1>, <set2>)]',
        },

        # SYMDIFF
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
            tags => ['op:symdiff'],
            module => 'Set::Array',
            function => 'symmetric_difference',
            code_template => 'my $s1 = Set::Array->new(@{<set1>}); my $s2 = Set::Array->new(@{<set2>}); $s1->symmetric_difference($s2)',
        },
        # Array::AsObject::symmetric_difference's handling of duplicates is
        # non-standard though, see its doc
        {
            tags => ['op:symdiff'],
            module => 'Array::AsObject',
            function => 'symmetric_difference',
            code_template => 'my $s1 = Array::AsObject->new(@{<set1>}); my $s2 = Array::AsObject->new(@{<set2>}); $s1->symmetric_difference($s2)',
        },
        {
            tags => ['op:symdiff'],
            module => 'Set::Object',
            function => 'symmetric_difference',
            code_template => 'my $s1 = Set::Object->new(@{<set1>}); my $s2 = Set::Object->new(@{<set2>}); $s1->symmetric_difference($s2)',
        },
        {
            tags => ['op:symdiff'],
            module => 'Set::Tiny',
            function => 'symmetric_difference',
            code_template => 'my $s1 = Set::Tiny->new(@{<set1>}); my $s2 = Set::Tiny->new(@{<set2>}); $s1->symmetric_difference($s2)',
        },
        {
            tags => ['op:symdiff'],
            module => 'List::Collection',
            function => 'complement',
            code_template => '[List::Collection::complement(<set1>, <set2>)]',
        },

        # DIFF
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
            tags => ['op:diff'],
            module => 'Set::Array',
            function => 'difference',
            code_template => 'my $s1 = Set::Array->new(@{<set1>}); my $s2 = Set::Array->new(@{<set2>}); $s1->difference($s2)',
        },
        # Array::AsObject::difference's handling of duplicates is non-standard
        # though, see its doc
        {
            tags => ['op:diff'],
            module => 'Array::AsObject',
            function => 'difference',
            code_template => 'my $s1 = Array::AsObject->new(@{<set1>}); my $s2 = Array::AsObject->new(@{<set2>}); $s1->difference($s2)',
        },
        {
            tags => ['op:diff'],
            module => 'Set::Object',
            function => 'difference',
            code_template => 'my $s1 = Set::Object->new(@{<set1>}); my $s2 = Set::Object->new(@{<set2>}); $s1->difference($s2)',
        },
        {
            tags => ['op:diff'],
            module => 'Set::Tiny',
            function => 'difference',
            code_template => 'my $s1 = Set::Tiny->new(@{<set1>}); my $s2 = Set::Tiny->new(@{<set2>}); $s1->difference($s2)',
        },
        {
            tags => ['op:diff'],
            module => 'List::Collection',
            function => 'subtract',
            code_template => '[List::Collection::subtract(<set1>, <set2>)]',
        },

        # INTERSECT
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
        {
            tags => ['op:intersect'],
            module => 'Set::Array',
            function => 'intersection',
            code_template => 'my $s1 = Set::Array->new(@{<set1>}); my $s2 = Set::Array->new(@{<set2>}); $s1->intersection($s2)',
        },
        {
            tags => ['op:intersect'],
            module => 'Array::AsObject',
            function => 'intersection',
            code_template => 'my $s1 = Array::AsObject->new(@{<set1>}); my $s2 = Array::AsObject->new(@{<set2>}); $s1->intersection($s2, 1)',
        },
        {
            tags => ['op:intersect'],
            module => 'Set::Object',
            function => 'intersection',
            code_template => 'my $s1 = Set::Object->new(@{<set1>}); my $s2 = Set::Object->new(@{<set2>}); $s1->intersection($s2)',
        },
        {
            tags => ['op:intersect'],
            module => 'Set::Tiny',
            function => 'intersection',
            code_template => 'my $s1 = Set::Tiny->new(@{<set1>}); my $s2 = Set::Tiny->new(@{<set2>}); $s1->intersection($s2)',
        },
        {
            tags => ['op:intersect'],
            module => 'List::Collection',
            function => 'intersect',
            code_template => '[List::Collection::intersect(<set1>, <set2>)]',
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
# ABSTRACT:

=head1 SEE ALSO

L<Benchmark::Featureset::SetOps>

Excluded modules: L<Set::Bag> (expects hashes instead of arrays),
L<Set::SortedArray> (members are sorted).

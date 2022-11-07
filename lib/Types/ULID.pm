package Types::ULID;

use v5.10;
use strict;
use warnings;

use Type::Library -base;
use Types::Standard qw(Undef);
use Types::Common::String qw(StrLength);
use Data::ULID;

my $ULID = Type::Tiny->new(
	name => 'ULID',
	parent => StrLength[26, 26],
	constraint => q{ tr/0-9a-hjkmnp-tv-zA-HJKMNP-TV-Z// == 26 },
	inlined => sub {
		my $varname = pop;
		return (undef, "($varname =~ tr/0-9a-hjkmnp-tv-zA-HJKMNP-TV-Z//) == 26");
	},

	coercion => [
		Undef, q{ Data::ULID::ulid() },
	],
);

my $BinaryULID = Type::Tiny->new(
	name => 'BinaryULID',
	parent => StrLength[16, 16],

	coercion => [
		Undef, q{ Data::ULID::binary_ulid() },
	],
);

__PACKAGE__->add_type($ULID);
__PACKAGE__->add_type($BinaryULID);

__PACKAGE__->make_immutable;


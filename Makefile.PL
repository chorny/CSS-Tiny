use strict;
use vars qw{$VERSION};
BEGIN {
	require 5.005;
}
use ExtUtils::MakeMaker;

WriteMakefile(
	MIN_PERL_VERSION => '5.005',
	META_MERGE => {
		resources => {
			repository => 'https://github.com/chorny/CSS-Tiny',
		},
	},
	NAME      => 'CSS::Tiny',
	ABSTRACT_FROM => 'lib/CSS/Tiny.pm',
	VERSION_FROM  => 'lib/CSS/Tiny.pm',
	PREREQ_PM => {
	},
	TEST_REQUIRES => {
		'Test::More' => '0.47',
	},
	AUTHOR  => 'Adam Kennedy <adamk@cpan.org>',
	LICENSE => 'perl',
	(-d 'xt' and $ENV{AUTOMATED_TESTING} || $ENV{RELEASE_TESTING}) ? (
		test => {
			TESTS => 't/*.t xt/*.t',
		},
	) : (),
    $^O =~/win/i ? (
        dist => {
            TAR      => 'ptar',
            TARFLAGS => '-c -C -f',
        },
    ) : (),
);

sub WriteMakefile {  #Written by Alexandr Ciornii, version 0.21. Added by eumm-upgrade.
	my %params=@_;
	my $eumm_version=$ExtUtils::MakeMaker::VERSION;
	$eumm_version=eval $eumm_version;
    if ($params{TEST_REQUIRES} and $eumm_version < 6.64) {
        $params{BUILD_REQUIRES}={ %{$params{BUILD_REQUIRES} || {}} , %{$params{TEST_REQUIRES}} };
        delete $params{TEST_REQUIRES};
    }
	if ( $params{BUILD_REQUIRES} and $eumm_version < 6.5503 ) {
		#EUMM 6.5502 has problems with BUILD_REQUIRES
		$params{PREREQ_PM} = {
			%{$params{PREREQ_PM} || {}},
			%{$params{BUILD_REQUIRES}}
		};
		delete $params{BUILD_REQUIRES};
	}
	delete $params{MIN_PERL_VERSION} if $eumm_version < 6.48;
	delete $params{META_MERGE} if $eumm_version < 6.46;
	delete $params{LICENSE} if $eumm_version < 6.31;

	ExtUtils::MakeMaker::WriteMakefile(%params);
}

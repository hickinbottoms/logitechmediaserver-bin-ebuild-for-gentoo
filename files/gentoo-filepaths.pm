# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

# This file contains a custom OS package to provide information on the
# installation structure on Gentoo.

package Slim::Utils::OS::Custom;

use strict;

use base qw(Slim::Utils::OS::Linux);

sub initDetails {
	my $class = shift;

	$class->{osDetails} = $class->SUPER::initDetails();

	$class->{osDetails}->{isGentoo} = 1 ;

	# Ensure we find manually installed plugin files.
	push @INC, '/var/opt/logitechmediaserver';
	push @INC, '/var/opt/logitechmediaserver/Plugins';

	return $class->{osDetails};
}

=head2 dirsFor( $dir )

Return OS Specific directories.

Argument $dir is a string to indicate which of the Logitech Media Server
directories we need information for.

=cut

sub dirsFor {
	my ($class, $dir) = @_;

	my @dirs = ();
	
	# We basically override the location of plugins, but let the default Linux
	# behaviour prevail for all other requests.
	push @dirs, $class->SUPER::dirsFor($dir);
	if ($dir eq 'Plugins') {
			
		push @dirs, '/var/opt/logitechmediaserver/Plugins';
		
	}

	return wantarray() ? @dirs : $dirs[0];
}

1;

__END__

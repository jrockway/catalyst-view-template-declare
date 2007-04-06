package Catalyst::View::Template::Declare;

use warnings;
use strict;
use base qw(Catalyst::View Template::Declare);

sub process {
    my ($self, $c) = @_;
    $c->response->body('Hello, world.');
}

1;
__END__

=head1 NAME

Catalyst::View::Template::Declare - Use Template::Declare in Catalyst

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

=head1 AUTHOR

Jonathan Rockway, C<< <jrockway at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-catalyst-view-template-declare at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Catalyst-View-Template-Declare>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Catalyst::View::Template::Declare

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Catalyst-View-Template-Declare>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Catalyst-View-Template-Declare>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Catalyst-View-Template-Declare>

=item * Search CPAN

L<http://search.cpan.org/dist/Catalyst-View-Template-Declare>

=back

=head1 ACKNOWLEDGEMENTS

L<Template::Declare>

=head1 COPYRIGHT & LICENSE

Copyright 2007 Jonathan Rockway, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.



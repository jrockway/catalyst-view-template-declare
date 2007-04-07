use warnings;
use strict;
my $context;

package Catalyst::View::Template::Declare;
use base qw(Catalyst::View Template::Declare);
use NEXT;
use Template::Declare::Tags;

our $VERSION = '0.00_01';

sub COMPONENT {
    my $class = shift;
    
    # init Template::Declare
    Template::Declare->init(roots => [$class]);
    
    $class->NEXT::COMPONENT(@_);
}

sub render {
    my ($self, $c, $template, @args) = @_;
    $context = $c;
    return Template::Declare->show($template);
}

sub process {
    my ($self, $c, @args) = @_;

    my $template = $c->stash->{template} || $c->action;
    my $html = $self->render($c, $template, @args);

    $c->response->body($html);
}

package c;
our $AUTOLOAD;
sub AUTOLOAD {
    shift; # kill class
    $AUTOLOAD =~ s/^c:://; # kill package c
    return $context->$AUTOLOAD(@_);
}

1;
__END__

=head1 NAME

Catalyst::View::Template::Declare - Use Template::Declare with Catalyst

=head1 VERSION

Version 0.00_01

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

Visit #catalyst on irc.perl.org, submit an RT ticket, or send me an e-mail.

=head1 ACKNOWLEDGEMENTS

L<Template::Declare>

L<Jifty>

=head1 COPYRIGHT & LICENSE

Copyright 2007 Jonathan Rockway, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.



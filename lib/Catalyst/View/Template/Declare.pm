use warnings;
use strict;
my $context;

package Catalyst::View::Template::Declare;
use base qw(Catalyst::View Template::Declare);
use NEXT;
use Template::Declare::Tags;
require Module::Pluggable::Object;

our $VERSION = '0.00_01';

sub COMPONENT {
    my $self  = shift;
    my $c     = shift;
    my $class = ref $self || $self;
    
    # find sub-templates
    my $mpo = Module::Pluggable::Object->new(require     => 0,
                                             search_path => $class,
                                            );
    my @extras = $mpo->plugins;
    foreach my $extra (@extras) {
        if (!eval "require $extra"){
            $c->log->warn("Couldn't include $extra: $@");
            next;
        }

        $c->log->debug("Loading subtemplate $extra") if $c->debug;
        eval q{push @}. $extra. q{::ISA, 'Template::Declare'};
    }
    
    # init Template::Declare
    Template::Declare->init(roots => [$class, @extras]);
    
    # init superclasses
    $self->NEXT::COMPONENT(@_);
}

sub render {
    my ($self, $c, $template, @args) = @_;
    $context = $c;
    Template::Declare->new_buffer_frame;
    my $out = Template::Declare->show($template);
    Template::Declare->end_buffer_frame;
    return $out;
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

Very experimental.

Make a view:

    package MyApp::View::TD;
    use base 'Catalyst::View::Template::Declare';
    use Template::Declare::Tags;
     
    template foo => sub { 
        html { 
            head { title { c->stash->{title} } };
            body { "Hello, world" }
          }
    };

In your app:

    $c->stash(template => 'foo');
    $c->stash(title => 'test');
    $c->detach('View::TD');

Outputs:

    <html><head><title>test</title></head><body>Hello, world</body></html>

You can also spread your templates out over multiple files.  If your
view is called MyApp::View::TD, then everything in MyApp::View::TD::*
will be included and templates declared in those files will be available
as though they were declared in your main view class.

Example:

    package MyApp::View::TD::Foo;
    use Template::Declare::Tags;
    template foo => sub { ... };
    1;

Then you can set C<< $c->stash(template => 'foo') >> and everything
will work as you expect.

=head1 METHODS

=head2 process

Render the template specified by the action or C<< $c->stash->template >>.

=head2 render($c, $template)

Render the template named by C<$template> and return the text.

=head2 COMPONENT

Private

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



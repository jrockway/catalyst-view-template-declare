use warnings;
use strict;
my $context;

package Catalyst::View::Template::Declare;
use base qw(Catalyst::View::Templated);
use Class::C3;
require Module::Pluggable::Object;

our $VERSION = '0.02';

sub COMPONENT {
    my $self  = shift;
    my $c     = shift;
    my $class = ref $self || $self;
    
    # find sub-templates
    my $mpo = Module::Pluggable::Object->new(require     => 0,
                                             search_path => $class,
                                            );
    
    # load sub-templates (and do a bit of magic niceness)
    my @extras = $mpo->plugins;
    foreach my $extra (@extras) {
        $c->log->info("Loading subtemplate $extra");
        
        # load module
        if (!eval "require $extra"){
            die "Couldn't include $extra: $@";
        }
        
        # make the templates a subclass of TD (required by TD)
        {
            no strict 'refs';
            push @{$extra. "::ISA"}, 'Template::Declare';
        }
        
    }
    
    # init Template::Declare
    Template::Declare->init(roots => [$class, @extras]);
    
    # init superclasses
    $self->next::method($c, @_);
}

sub _render {
    my ($self, $template, $stash, $args) = @_;
    $context = $self->context;

    Template::Declare->new_buffer_frame;
    my $out = Template::Declare->show($template);
    Template::Declare->end_buffer_frame;
    
    return $out;
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

Version 0.02

=head1 SYNOPSIS

Create the view:

     myapp_create.pl view TD Template::Declare

Add templates in C<< MyApp::View::TD::<name> >>:

     package MyApp::View::TD::Test;
     use Template::Declare::Tags;

     template foo => sub { html {} };
     template bar => sub {   ...   };
     1;

Then use the templates from your application:

     $c->view('TD')->template('foo');
     $c->detach('View::TD');

You can get at the Catalyst context via the C<<c>> package:

     template foo => sub { "This is the ". c->action. " action." };
     template bar => sub { "Hello, ". c->stash->{world} };

Have fun.  This is all somewhat experimental and subject to change.

=head1 DESCRIPTION

Make a view:

    package MyApp::View::TD;
    use base 'Catalyst::View::Template::Declare';
    1;

Make a template:

    package MyApp::View::TD::Root;
    use Template::Declare::Tags;
     
    template foo => sub { 
        html { 
            head { title { c->stash->{title} } };
            body { "Hello, world" }
          }
    };

In your app:

    $c->view('TD')->template('foo');
    $c->stash(title => 'test');
    $c->detach('View::TD');

And get the output:

    <html><head><title>test</title></head><body>Hello, world</body></html>

You can spread your templates out over multiple files.  If your
view is called MyApp::View::TD, then everything in MyApp::View::TD::*
will be included and templates declared in those files will be available
as though they were declared in your main view class. 

Example:

    package MyApp::View::TD::Foo;
    use Template::Declare::Tags;
    template bar => sub { ... };
    1;

Then you can set C<< $c->view('TD')->template('bar') >> and everything
will work as you expect.

=head1 METHODS

=head2 process

Render the template in C<< $self->template >>; see
L<Catalyst::View::Templated> for information on how to specify the
template.

=head2 render($template)

Render the template named by C<$template> and return the output.

=head2 COMPONENT

Not for you.

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

The git repository is at L<http://git.jrock.us/>.

=head1 SEE ALSO

L<Catalyst::View::Templated>

=head1 ACKNOWLEDGEMENTS

L<Template::Declare>

L<Jifty>

=head1 COPYRIGHT & LICENSE

Copyright 2007 Jonathan Rockway, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.



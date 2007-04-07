#!perl

package TestApp::Controller::Root;
use strict;
use warnings;
use base 'Catalyst::Controller';

__PACKAGE__->config(namespace => '');

sub action_name :Local {
    my ($self, $c, @args) = @_;
    $c->detach('View::TD');
}

sub test_stash :Local {
    my ($self, $c, @args) = @_;
    $c->stash(world => "World");
    $c->stash(template => "stash");
    $c->detach('View::TD');
}

1;

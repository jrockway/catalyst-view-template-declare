#!perl

package TestApp::Controller::Root;
use strict;
use warnings;
use base 'Catalyst::Controller';

__PACKAGE__->config(namespace => '');

sub action_name :Local {}

sub test_stash :Local {
    my ($self, $c, @args) = @_;
    $c->stash(world => "World");
    $c->stash(template => 'stash');
}

sub test_sub :Local {
    my ($self, $c, @args) = @_;
    $c->stash(template => 'subtemplate');
}

sub test_includeother :Local {
    my ($self, $c, @args) = @_;
    $c->stash(template => 'includeother');
}

sub end :Private {
    my ($self, $c, @args) = @_;
    $c->detach('View::TD');
}

1;


package TestApp::View::TD;
use strict;
use warnings;
use base 'Catalyst::View::Template::Declare';
use Template::Declare::Tags;
template action_name => sub {
    p { "This is the action_name template." };
};

template stash => sub {
    p { "Hello, ". c->stash->{world} };
};

1;

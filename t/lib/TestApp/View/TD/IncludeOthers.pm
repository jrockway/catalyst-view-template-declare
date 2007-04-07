package TestApp::View::TD::IncludeOthers;
use strict;
use warnings;

template includeother => sub {
    p { "This comes before the other template." };
    show('subtemplate');
};

1;

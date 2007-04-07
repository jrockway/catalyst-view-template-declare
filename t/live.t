#!/usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 4;
use FindBin qw($Bin);
use lib "$Bin/lib";
use Catalyst::Test qw(TestApp);

is(get('/action_name'), "\n<p>This is the action_name template.\n</p>", 
     'action name works');
is(get('/test_stash'), "\n<p>Hello, World\n</p>", 
     'getting data from stash works');
is(get('/test_sub'), "\n<p>This is a subtemplate.\n</p>",
     'templates in other files work');
is(get('/test_includeother'), 
   "\n<p>This comes before the other template.\n</p>".
   "\n<p>This is a subtemplate.\n</p>",
   'a subtemplate that includes another subtemplate');


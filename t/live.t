#!/usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 2;
use FindBin qw($Bin);
use lib "$Bin/lib";
use Catalyst::Test qw(TestApp);

like(get('/action_name'), qr'This is the action_name template[.]', 'action name works');
like(get('/test_stash'), qr'Hello, World', 'getting data from stash works');


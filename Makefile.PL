use inc::Module::Install;

name 'Catalyst-View-Template-Declare';
all_from 'lib/Catalyst/View/Template/Declare.pm';

build_requires 'Test::More';

auto_install;

WriteAll;


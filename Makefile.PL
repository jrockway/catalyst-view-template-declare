use inc::Module::Install;

name 'Catalyst-View-Template-Declare';
all_from 'lib/Catalyst/View/Template/Declare.pm';
requires 'Catalyst::View';
requires 'Template::Declare' => '0.21';
requires 'NEXT';
requires 'Module::Pluggable::Object';

build_requires 'Test::More';
auto_install;
WriteAll;

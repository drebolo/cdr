#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

require_ok('Aurora::Task::ProcessFile');
can_ok('Aurora::Task::ProcessFile', qw/register _process_file _convert_date _populate/);

done_testing();

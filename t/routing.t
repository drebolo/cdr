use Mojo::Base -strict;

use Test::More;
use Test::Mojo;


my $t = Test::Mojo->new( 'Aurora' );
$t->get_ok('/')->status_is(200)->content_like(qr/Call Detail Record/i);

my $data = {
  inputFile => { file => 'no_file' },
};
$t->post_ok('/upload' => form => $data)->status_is(400)->content_like(qr/No or empty file provided/i);

# GET number of calls
$t->get_ok('/calls/max/week')->status_is(200)->content_like(qr/max number of calls per week/i);
$t->get_ok('/calls/min/day')->status_is(200)->content_like(qr/min number of calls per day/i);
$t->get_ok('/calls/average/month')->status_is(200)->content_like(qr/average number of calls per month/i);

# GET cost
$t->get_ok('/cost/max')->status_is(200)->content_like(qr/max cost/i);
$t->get_ok('/cost/min')->status_is(200)->content_like(qr/min cost/i);
$t->get_ok('/cost/average')->status_is(200)->content_like(qr/average cost/i);

# GET duration
$t->get_ok('/duration/max')->status_is(200)->content_like(qr/max duration/i);
$t->get_ok('/duration/min')->status_is(200)->content_like(qr/min duration/i);
$t->get_ok('/duration/average')->status_is(200)->content_like(qr/average duration/i);

done_testing();

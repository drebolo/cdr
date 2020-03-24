package Aurora;
use Mojo::Base 'Mojolicious';

sub startup {
  my $self = shift;

  my $config = $self->plugin('Config');
  $self->secrets( $config->{secrets} );
  $self->plugin( 'Minion' => $config->{minion} );
  $self->plugin('DBIC');
  $self->plugin('Aurora::Task::ProcessFile');
  $self->max_request_size(5368709120);

  my $r = $self->routes;
  $r->get('/')->to('CallDetailRecord#index');

  $r->post('/upload')->to('CallDetailRecord#upload');

  my $cost = $r->get('/cost')->to( controller => 'CallDetailRecord::Cost' );
  $cost->get('/average')->to( action => 'average' );
  $cost->get('/max')->to( action => 'max' );
  $cost->get('/min')->to( action => 'min' );

  my $duration = $r->get('/duration')->to( controller => 'CallDetailRecord::Duration' );
  $duration->get('/average')->to( action => 'average' );
  $duration->get('/max')->to( action => 'max' );
  $duration->get('/min')->to( action => 'min' );

  my $period = [ period => [ 'day', 'week', 'month', 'year' ] ];
  my $calls  = $r->get('calls')->to( controller => 'CallDetailRecord::Call' );
  $calls->get( '/average/:period' => $period )->to( action => 'average' );
  $calls->get( '/min/:period'     => $period )->to( action => 'min' );
  $calls->get( '/max/:period'     => $period )->to( action => 'max' );

}

1;

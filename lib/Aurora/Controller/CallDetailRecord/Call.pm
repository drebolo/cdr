package Aurora::Controller::CallDetailRecord::Call;
use Mojo::Base 'Mojolicious::Controller';

sub average {
  my $self = shift;

  my $period  = $self->stash('period');
  my $average = $self->_calls_count($period)->func('AVG');
  $self->render(
    json => { "average number of calls per $period" => $average } );
}

sub min {
  my $self = shift;

  my $period  = $self->stash('period');
  my $average = $self->_calls_count($period)->func('MIN');
  $self->render( json => { "min number of calls per $period" => $average } );
}

sub max {
  my $self = shift;

  my $period  = $self->stash('period');
  my $average = $self->_calls_count($period)->func('MAX');
  $self->render( json => { "max number of calls per $period" => $average } );
}

sub _calls_count {
  my ( $self, $period ) = @_;
  my $calls = $self->_resultset->search(
    undef,
    {
      columns  => [ \"COUNT(call_date) as call_count" ],
      group_by => [ \"YEAR(call_date)", \"$period(call_date)" ]
    }
  )->get_column('call_count');
}

sub _resultset {
  my ($self) = @_;

  return $self->app->schema->resultset('CallDetailRecord');
}

1;

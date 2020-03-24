package Aurora::Controller::CallDetailRecord::Duration;
use Mojo::Base 'Mojolicious::Controller';

sub average {
  my $self = shift;

  $self->render(
    json => { 'call average duration' => $self->_duration->func('AVG') }
  );
}

sub max {
  my $self = shift;

  $self->render(
    json => { 'call max duration' => $self->_duration->func('MAX') }
  );
}

sub min {
  my $self = shift;

  $self->render(
    json => { 'call min duration' => $self->_duration->func('MIN') }
  );
}

sub _duration {
  my ($self) = @_;

  my $cost = $self->_resultset->get_column('duration');
}

sub _resultset {
  my ($self) = @_;

  return $self->app->schema->resultset('CallDetailRecord');
}

1;

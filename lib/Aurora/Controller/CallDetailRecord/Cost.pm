package Aurora::Controller::CallDetailRecord::Cost;
use Mojo::Base 'Mojolicious::Controller';

sub average {
  my $self = shift;

  $self->render(
    json => { 'call average cost' => $self->_cost->func('AVG') }
  );
}

sub max {
  my $self = shift;

  $self->render(
    json => { 'call max cost' => $self->_cost->func('MAX') }
  );
}

sub min {
  my $self = shift;

  $self->render(
    json => { 'call min cost' => $self->_cost->func('MIN') }
  );
}

sub _cost {
  my ($self) = @_;

  my $cost = $self->_resultset->get_column('cost');
}

sub _resultset {
  my ($self) = @_;

  return $self->app->schema->resultset('CallDetailRecord');
}

1;

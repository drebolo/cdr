package Aurora::Controller::CallDetailRecord;
use Mojo::Base 'Mojolicious::Controller';
use File::Spec::Functions qw/catfile tmpdir/;

sub index {
  my $self = shift;

  $self->render(
    json => ["Call Detail Record"]
  );
}

sub upload {
  my $self = shift;

  my $upload = @{$self->req->uploads}[0];
  if (! $upload->size) {
    $self->render( json => 'No or empty file provided',status => 400 );
    return;
  }
  my $queue_id = $self->_queue_upload($upload);
  $self->render(
    json => ["Upload queued to process with id: $queue_id"]
  );
}

sub _queue_upload {
  my ($self, $upload) = @_;

  my $file_path = catfile(tmpdir(), time . '-' . $upload->filename);
  $upload->move_to($file_path);
  return $self->minion->enqueue(process_file => [$file_path] );
}

1;

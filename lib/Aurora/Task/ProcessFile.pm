package Aurora::Task::ProcessFile;
use Mojo::Base 'Mojolicious::Plugin';
use Text::CSV;

use constant BATCH_SIZE => 999;

sub register {
  my ($self, $app) = @_;

  $app->minion->add_task(process_file => \&_process_file);
}

sub _process_file {
  my ($job, $file) = @_;

  my ($rows, $batch, $counter) = [], 0, 0;
  my $csv = Text::CSV->new ({ binary => 1, auto_diag => 1 });
  open my $fh, "<:encoding(utf8)", $file or die ": $!";
  my $header = $csv->getline($fh);

  while (my $row = $csv->getline($fh)) {
    $batch++;
    $row->[2] = _convert_date($row->[2]);
    push @$rows, $row;
    if ($batch > BATCH_SIZE) {
      _populate($job->app->schema, $rows, $header);
      $batch = 0;
      $rows = [];
    }
    $counter++;
  }
  # populate last remaining rows.
  if (scalar @$rows) {
    _populate($job->app->schema, $rows, $header);
  }

  $job->finish("New $counter CDR rows inserted.");
}

sub _convert_date {
  my ($date) = @_;

  # date should be yyyy-mm-dd
  my($day,$month,$year) = $date =~ m/^(\d+)\/(\d+)\/(\d+)/;
  return "$year-$month-$day";
}

sub _populate {
  my ($schema, $rows, $header) = @_;

  # include headers
  unshift @$rows, $header;
  $schema->resultset('CallDetailRecord')->populate($rows);
}


1;

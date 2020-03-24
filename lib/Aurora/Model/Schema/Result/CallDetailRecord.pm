use utf8;
package Aurora::Model::Schema::Result::CallDetailRecord;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Aurora::Model::Schema::Result::CallDetailRecord

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<call_detail_record>

=cut

__PACKAGE__->table("call_detail_record");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0

=head2 caller_id

  data_type: 'varchar'
  is_nullable: 1
  size: 12

=head2 recipient

  data_type: 'varchar'
  is_nullable: 0
  size: 12

=head2 call_date

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=head2 end_time

  data_type: 'time'
  is_nullable: 0

=head2 duration

  data_type: 'smallint'
  is_nullable: 0

=head2 cost

  data_type: 'decimal'
  is_nullable: 0
  size: [10,3]

=head2 reference

  data_type: 'varchar'
  is_nullable: 0
  size: 40

=head2 currency

  data_type: 'varchar'
  is_nullable: 0
  size: 3

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "bigint", is_auto_increment => 1, is_nullable => 0 },
  "caller_id",
  { data_type => "varchar", is_nullable => 1, size => 12 },
  "recipient",
  { data_type => "varchar", is_nullable => 0, size => 12 },
  "call_date",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 0 },
  "end_time",
  { data_type => "time", is_nullable => 0 },
  "duration",
  { data_type => "smallint", is_nullable => 0 },
  "cost",
  { data_type => "decimal", is_nullable => 0, size => [10, 3] },
  "reference",
  { data_type => "varchar", is_nullable => 0, size => 40 },
  "currency",
  { data_type => "varchar", is_nullable => 0, size => 3 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-03-21 14:08:00
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:GFrqnTUfZBqM4c9UFTNaYA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

package Examples::Generator;

# DATE
# VERSION

1;
# ABSTRACT: A specification/convention for modules that generate sample data

=head1 SPECIFICATION VERSION

0.1


=head1 NOTATION

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD",
"SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be
interpreted as described in RFC 2119.


=head1 STATUS

Experimental, specification might change without notice.


=head1 DESCRIPTION

This document describes a set of convention for modules that generate sample
data.

Such modules should be named C<*::Examples>, for example:
L<PERLANCAR::Tree::Examples>, L<PERLANCAR::HTML::Tree::Examples>.

There must be a function in the module called C<gen_sample_data()>. This
function must have an accompanying L<Rinci> metadata to describe it. This
function must have C<result_naked> property set to true. This function may be
set as C<immutable> (meaning always generates the same return value given the
same arguments) or not.

B<Data parameter argument.> There may be zero or more arguments that regulate
the variation of the sample data produced, for example a module that generates a
sample person name might have arguments: C<gender>, C<nationality>. These
arguments must be tagged with C<data-parameter>. They must be of simple type and
have the allowed possible values defined either using the C<in> schema clause,
or C<min>/C<max>/C<xmin>/C<xmax>. For example:

 $SPEC{gen_sample_data} = {
     v => 1.1,
     summary => 'Generate sample person name',
     args => {
         gender => {
             schema => ['str*', in => ['M', 'F']],
             tags => ['data-parameter'],
         },
         nationality => {
             schema => ['str*', in => ['id', 'my', 'sg', 'th', 'ph', 'bn']],
             tags => ['data-parameter'],
         },
     },
     result_naked => 1,
 };

These data parameter arguments may be required or not. If a data parameter
argument is not required, usually this means a random default will be chosen for
it when not specified.

The data parameter arguments are tagged so other tools, like a POD generator,
could generate an overview of sample data by permuting all the data parameter
arguments and showing what the sample data would look like.


=head1 SEE ALSO

L<Rinci>, L<Rinci::function>

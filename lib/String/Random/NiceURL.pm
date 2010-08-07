package String::Random::NiceURL;

use warnings;
use strict;
use Carp qw(croak);
use base 'Exporter';
use Scalar::Util qw(looks_like_number);

our @EXPORT_OK = qw(id);
our $VERSION = '0.01';

# the end chars are the first and last chars of the ID
# the modified base 64 chars are as follows: http://en.wikipedia.org/wiki/Base64#URL_applications
my @end_chars = ( 'A'..'Z', 'a'..'z', '0'..'9' );
my @modified_b64 = ( @end_chars, '-', '_' );
my $end_chars_length = scalar @end_chars;
my $modified_b64_length = scalar @modified_b64;

sub id {
    my ($length) = @_;

    # make the arg numeric
    # $length = int $length;

    croak "Please provide a length greater than or equal to 2"
        unless defined $length and looks_like_number($length) and $length >= 2;

    my $str = '';

    # firstly, make up the central part using the modified base 64 chars
    foreach ( 1..$length-2 ) {
        my $rand = int(rand() * $modified_b64_length);
        $str .= $modified_b64[$rand];
    }

    # and return it with the end chars in place
    return $end_chars[int(rand() * $end_chars_length)] . $str . $end_chars[int(rand() * $end_chars_length)];
}

1;

=head1 NAME

String::Random::NiceURL - create random ID strings for URLs by only using the
modified Base64 characters

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

    use String::Random::NiceURL qw(id);
    my $id = id(6);
    print "id=$id\n";

=head1 DESCRIPTION

This module allows you to create sparse and distributed IDs such as those used
for YouTube videos. It uses a modified base 64 character set but also makes
sure that the first and last chars of your ID are not the dash or underscore
characters (this helps some programs detect the URLs correctly, for example
when double-clicking to highlight the text).

Any length IDs (greater than two chars) can be created and could be used for
blog posts, short URLs, images, videos and many other entities.

Other uses could be salts, session IDs, tokens when checking email addresses
and nonces for XSRF tokens.

As an example, let's generate an ID of length 6:

    use String::Random::NiceURL qw(id);
    my $id = id(6);
    print "id=$id\n";

This could print something like (for values of 2, 6, 11, 32):

    id(2)  => 6p
    id(6)  => NIK_qV
    id(11) => 2qUROkj-1X6
    id(32) => sTQ9TP-Y-2cpKlL1f2-6VCgWvAYTZTDB
    ...etc...

=head1 EXPORT_OK

=head2 id

This is the only method provided by this module. It can be exported, or called
as such:

    String::Random::NiceURL::id($length)

It will return an example ID string of the specified number of characters.

If the length if not provided, non-numeric or less than two, the function will
croak with a user-error message.

=head1 AUTHOR

Andrew Chilton, C<< <andy at chilts dot org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-string-random-niceurl at rt.cpan.org>,
or through the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=String-Random-NiceURL>.
I will be notified, and then you'll automatically be notified of progress on your
bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc String::Random::NiceURL

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=String-Random-NiceURL>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/String-Random-NiceURL>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/String-Random-NiceURL>

=item * Search CPAN

L<http://search.cpan.org/dist/String-Random-NiceURL>

=back

=head1 COPYRIGHT & LICENSE

Copyright (c) 2010, Apps Attic Ltd, all rights reserved.

L<http://www.appsattic.com/>

This module is free software. You can redistribute it and/or modify it under
the terms of the Artistic License 2.0.

This program is distributed in the hope that it will be useful, but without any
warranty; without even the implied warranty of merchantability or fitness for a
particular purpose.

=cut

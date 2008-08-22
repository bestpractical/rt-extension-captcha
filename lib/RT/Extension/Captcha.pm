package RT::Extension::Captcha;

use 5.008003;
use strict;
use warnings;

our $VERSION = '0.01';

use GD::SecurityImage;

=head1 NAME

RT::Extension::Captcha - solve a CAPTCHA before some actions in RT

=head1 DESCRIPTION

This extension for RT 3.8.1 or newer. At this point only captcha is
required for creating a ticket. Users who have right 'OnCaptchaOnCreate'
will see no captchas.

As GD's built in font is kinda small, we enabled ttf support and
it's not configurable at this point. Either hack this extension
or set an absolute path to a ttf font via 'ChartFont' option in
the RT config.

=head1 INSTALLATION

    perl Makefile.PL
    make
    make install

In the RT config:

    Set(@Plugins, 'RT::Extension::Captcha', ... other extensions ... );

=cut

use RT::Queue;
$RT::Queue::RIGHTS->{'NoCaptchaOnCreate'} = "Don't ask user to solve a CAPTCHA on ticket create"; #loc_pair
$RT::Queue::RIGHTS->{'NoCaptchaOnUpdate'} = "Don't ask user to solve a CAPTCHA on ticket reply or comment"; #loc_pair

=head1 LICENSE

Under the same terms as perl itself.

=head1 AUTHOR

Ruslan Zakirov E<lt>ruz@bestpractical.comE<gt>

=cut

1;

package RT::Extension::Captcha;

use 5.008003;
use strict;
use warnings;

our $VERSION = '0.01';

use GD::SecurityImage;

=head1 NAME

RT::Extension::Captcha - solve a CAPTCHA before some actions in RT

=head1 DESCRIPTION

This extension is for RT 3.8.1 or newer. At this point solving captchas is
required when user create a ticket using either regular interface or
quick create (with 3.8.2 or newer only) and on replies/comments (updates).

=head1 INSTALLATION

    perl Makefile.PL
    make
    make install

In the RT config:

    Set(@Plugins, 'RT::Extension::Captcha', ... other extensions ... );

=head1 CONFIGURATION

=head2 No CAPTCHA rights

Users who have right 'NoCaptchaOnCreate' or 'NoCaptchaOnUpdate'
will see no captchas on corresponding actions.

=head2 Font

As GD's builtin font is kinda small. A ttf font is used instead.
By default font defined by ChartFont option (RT's option to set
fonts for charts) is used for CAPTCHA images.

As well, you can set font for cpatchas only using L</%Captcha option>
described below.

=head2 %Captcha option

See F<etc/Captcha_Config.pm> for defaults and example. C<%Captcha>
option is a hash. Now, only ImageProperties key has meaning:

    Set(%Captcha,
        ImageProperties => {
            option => value,
            option => value,
            ...
        },
    );

ImageProperties are passed into L<GD::SecurityImage/new>. Read documentation
for the module for full list of options.

=cut

use RT::Queue;
$RT::Queue::RIGHTS->{'NoCaptchaOnCreate'} = "Don't ask user to solve a CAPTCHA on ticket create"; #loc_pair
$RT::Queue::RIGHTS->{'NoCaptchaOnUpdate'} = "Don't ask user to solve a CAPTCHA on ticket reply or comment"; #loc_pair

if ($RT::Queue::RIGHT_CATEGORIES) {
    $RT::Queue::RIGHT_CATEGORIES->{"NoCaptchaOn$_"} = 'Staff'
        for qw(Create Update);
}

use RT::ACE;
$RT::ACE::LOWERCASERIGHTNAMES{ lc $_ } = $_
    foreach qw(NoCaptchaOnCreate NoCaptchaOnUpdate);

=head1 LICENSE

Under the same terms as perl itself.

=head1 AUTHOR

Ruslan Zakirov E<lt>ruz@bestpractical.comE<gt>

=cut

1;

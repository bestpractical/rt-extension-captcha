package RT::Extension::Captcha;

use 5.008003;
use strict;
use warnings;

our $VERSION = '1.00';

use GD::SecurityImage;

=head1 NAME

RT::Extension::Captcha - solve a CAPTCHA before some actions in RT

=head1 DESCRIPTION

This extension is for RT 3.8.1 or newer.  It requires solving captchas
when a user creates a ticket (using either regular interface or quick
create) and on replies/comments (updates).

=head1 INSTALLATION

=over

=item C<perl Makefile.PL>

=item C<make>

=item C<make install>

May need root permissions

=item Edit your F</opt/rt4/etc/RT_SiteConfig.pm>

If you are using RT 4.2 or greater, add this line:

    Plugin('RT::Extension::Captcha');

For RT 4.0, add this line:

    Set(@Plugins, qw(RT::Extension::Captcha));

or add C<RT::Extension::Captcha> to your existing C<@Plugins> line.

=item Clear your mason cache

    rm -rf /opt/rt4/var/mason_data/obj

=item Restart your webserver

=back

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

=head1 AUTHOR

Best Practical Solutions, LLC E<lt>modules@bestpractical.comE<gt>

=head1 BUGS

All bugs should be reported via email to

    L<bug-RT-Extension-Captcha@rt.cpan.org|mailto:bug-RT-Extension-Captcha@rt.cpan.org>

or via the web at

    L<rt.cpan.org|http://rt.cpan.org/Public/Dist/Display.html?Name=RT-Extension-Captcha>.

=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2014 by Best Practical Solutions

This is free software, licensed under:

  The GNU General Public License, Version 2, June 1991

=cut

1;

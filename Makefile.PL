use inc::Module::Install;

RTx         'RT-Extension-Captcha';
all_from    'lib/RT/Extension/Captcha.pm';
readme_from 'lib/RT/Extension/Captcha.pm';

{ # check RT version
    my @v = split /\./, "$RT::VERSION";
    unless ($v[0]>=3 && $v[1]>=8 && ($v[2]>=1 || $v[2]eq'HEAD')) {
        die "RTIR 2.4 and newer needs RT 3.8.1 at least, you have $RT::VERSION";
    }
}

requires 'GD::SecurityImage';

WriteAll();


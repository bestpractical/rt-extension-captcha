use inc::Module::Install;

RTx         'RT-Extension-Captcha';
all_from    'lib/RT/Extension/Captcha.pm';
readme_from 'lib/RT/Extension/Captcha.pm';

requires_rt '3.8.1';
requires 'GD::SecurityImage';

WriteAll();


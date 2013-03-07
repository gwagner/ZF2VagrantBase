class php
{
    require php::config, repo_epel, repo_ius

    package
    {
        ['re2c']:
            ensure => installed,
            provider => 'yum',
            require => Yumrepo['epel'];

        "${php::config::php_prefix}-common-${php::config::php_version}":
            ensure => installed,
            provider => 'yum',
            require => [
                Yumrepo['ius'],
                Package['re2c'],
                Package['gcc']
            ],
            alias => 'php-common';

        "${php::config::php_prefix}-cli-${php::config::php_version}":
            ensure => installed,
            provider => 'yum',
            require => [
                Yumrepo['ius'],
                Package['re2c'],
                Package['gcc'],
                Package['php-common']
            ],
            alias => 'php-cli';

        "${php::config::php_prefix}-devel-${php::config::php_version}":
            ensure => installed,
            provider => 'yum',
            require => [
                Yumrepo['ius'],
                Yumrepo['ius-development'],
                Package['re2c'],
                Package['gcc'],
                Package["php-common"],
                Package["php-cli"],
            ],
            alias => 'php-devel';
    }

    file{
        'php-ini':
            mode => 644,
            owner => "root",
            group => "root",
            path => "/etc/php.ini",
            content => template('php/php-ini.erb'),
            require => [
                Package["php-cli"]
            ];
        '/etc/php.d':
            ensure => 'directory',
            mode   => 0644,
            owner  => 'root',
            group  => 'root';
    }
}
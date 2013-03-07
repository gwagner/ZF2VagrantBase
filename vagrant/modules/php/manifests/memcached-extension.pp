class php::memcached-extension
{
    include php::config, repo_epel, repo_ius

    package
    {
        'libmemcached-devel':
            ensure => absent,
            provider => 'yum',
            require => [
                Yumrepo['epel']
            ];

        'libmemcached':
            ensure => absent,
            provider => 'yum',
            require => [
                Package['libmemcached-devel'],
                Yumrepo['epel']
            ];

        ['libmemcached10', 'libmemcached10-devel']:
            ensure => installed,
            provider => 'yum',
            require => [Yumrepo['ius', 'ius-development']];

        'php-ext-memcached':
            name => "${php::config::php_prefix}-pecl-memcached-${php::config::memcached_version}",
            ensure => installed,
            provider => 'yum',
            require => [
                Package[
                    "${php::config::php_prefix}-pear-${php::config::php_pear_version}",
                    'libmemcached10',
                    'libmemcached10-devel'
                ],
                Yumrepo['ius', 'ius-development']
            ];
    }

    file
    {
        'memcached-extension-ini':
            mode => 644,
            owner => "root",
            group => "root",
            path => "/etc/php.d/memcached.ini",
            content => template('php/memcached-extension-ini.erb'),
            require => [
                Package["${php::config::php_prefix}-pecl-memcached-${php::config::memcached_version}"],
                Package["${php::config::php_prefix}-common-${php::config::php_version}"],
                Package["${php::config::php_prefix}-devel-${php::config::php_version}"],
                File['/etc/php.d']
            ];
    }
}
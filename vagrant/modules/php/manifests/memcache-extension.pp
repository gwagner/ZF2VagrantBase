class php::memcache-extension
{
    include php::config, repo_epel, repo_ius

    package
    {
        ['libmemcached', 'libmemcached-devel']:
            ensure => installed,
            provider => 'yum',
            require => [Yumrepo['epel']];

        'php-ext-memcache':
            name => "${php::config::php_prefix}-pecl-memcache-${php::config::memcache_version}",
            ensure => installed,
            provider => 'yum',
            require => [
                Package[
                    "${php::config::php_prefix}-pear-${php::config::php_pear_version}",
                    'libmemcached',
                    'libmemcached-devel'
                ]
            ];
    }

    file
    {
        'memcache-extension-ini':
            mode => 644,
            owner => "root",
            group => "root",
            path => "/etc/php.d/memcache.ini",
            content => template('php/memcache-extension-ini.erb'),
            require => [
                Package["${php::config::php_prefix}-common-${php::config::php_version}"],
                Package["${php::config::php_prefix}-devel-${php::config::php_version}"],
                File['/etc/php.d']
            ];
    }
}
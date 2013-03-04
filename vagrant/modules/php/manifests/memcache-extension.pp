class php::memcache-extension
{
    include php::config, repo-epel, repo-ius

    package
    {
        ['libmemcached', 'libmemcached-devel']:
            ensure => installed,
            provider => 'yum',
            require => [Yumrepo['epel']];

        ["${php::config::php_prefix}-pecl-memcache-${php::config::memcached_version}"]:
            ensure => installed,
            provider => 'yum',
            require => [
                Package["${php::config::php_prefix}-pear-${php::config::php_pear_version}"]
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
                Package["${php::config::php_prefix}-devel-${php::config::php_version}"]
            ];
    }
}
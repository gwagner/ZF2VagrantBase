class memcached
{
    require repo_centos, repo_epel

    package{
        ['memcached', 'memcached-devel']:
            ensure => installed,
            provider => 'yum',
            require => Yumrepo['epel','centos-base', 'centos-updates', 'centos-extras'];
    }

    file{
        '/etc/sysconfig/memcached':
            mode => 644,
            owner => "root",
            group => "root",
            path => "/etc/sysconfig/memcached",
            content => template('memcached/memcached.erb'),
            require => [
                Package['memcached']
            ];
    }

    service{
        'memcached':
            ensure => true,
            enable => true,
            hasrestart => true,
            hasstatus => true,
            subscribe => [
                Package['memcached'],
                File['/etc/sysconfig/memcached']
            ]
    }
}
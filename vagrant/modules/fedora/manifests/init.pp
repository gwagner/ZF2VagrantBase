class fedora {

    file {

        '/etc/fstab':
            ensure => present,
            mode   => 0644,
            owner  => 'root',
            group  => 'root';

        '/etc/passwd':
            ensure => present,
            mode   => 0644,
            owner  => 'root',
            group  => 'root';

        '/etc/crontab':
            ensure => present,
            mode   => 0644,
            owner  => 'root',
            group  => 'root';

        '/etc/yum.conf':
            ensure => present,
            mode   => 0644,
            owner  => 'root',
            group  => 'root',
            source => "puppet:///modules/fedora/yum.conf";
    }

    # always test with noop first!
    resources {
        'host':
            purge => true;
    }

    service {
        'network':
            ensure => true,
            enable => true,
            hasrestart => true,
            hasstatus => true;
    }

    package {
        'gcc':
            ensure => 'installed',
            provider => 'yum';
    }

    # host entry with multiple aliases
    host {
        'localhost':
            ip => '127.0.0.1',
            host_aliases => [ 'localhost.localdomain' ],
            ensure => present,
            target => '/etc/hosts';

        'localhost6':
            ip => '::1',
            host_aliases => [ 'localhost6.localdomain6' ],
            ensure => present,
            target => '/etc/hosts';
    }
}
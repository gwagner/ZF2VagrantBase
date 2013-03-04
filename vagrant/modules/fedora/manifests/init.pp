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

        '/etc/ntp.conf':
            ensure => present,
            mode   => 0644,
            owner  => 'root',
            group  => 'root',
            source => "puppet:///modules/fedora/ntp.conf",
            notify => Service['ntpd'];
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

        # Machine stats that can be polled very easily
        'ntpd':
            ensure => true,
            enable => true,
            require => [
                File['/etc/ntp.conf'],
                Package['ntp']
            ],
            subscribe => File['/etc/ntp.conf'];
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
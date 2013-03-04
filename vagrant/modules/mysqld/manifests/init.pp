class mysqld
{
    package {
        ["mysql-server"]:
            ensure => installed,
            provider => 'yum';
    }

     service {
        'mysqld':
            ensure => true,
            enable => true,
            hasrestart => true,
            hasstatus => true;
    }

    exec{
        'mysql_set_root_password':
            command => "/usr/bin/mysqladmin -u root password 'root' && touch /var/lib/mysql_set_root_password.lock",
            user => 'root',
            creates => "/var/lib/mysql_set_root_password.lock",
            require => [
                Package['mysql-server'],
                Service['mysqld']
            ];
    }
}
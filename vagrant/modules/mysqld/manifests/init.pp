class mysqld
{
    require repo_centos

    package {
        ["mysql-server"]:
            ensure => installed,
            provider => 'yum',
            require => Yumrepo['centos-base', 'centos-updates', 'centos-extras'];
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
class httpd
{
    include httpd::config

    add_user {
        "apache":
            email => 'apache@neufocus-development.dev',
            uid => '20002';
    }

    package {
        ["httpd-tools-${httpd::config::httpd_version}", "httpd-devel-${httpd::config::httpd_version}"]:
            ensure => installed,
            provider => 'yum',
            require => Yumrepo['centos-base', 'centos-updates', 'centos-extras'];
        'httpd':
            name => "httpd-${httpd::config::httpd_version}",
            ensure => installed,
            provider => 'yum',
            alias => 'httpd',
            require => [
                Package["httpd-tools-${httpd::config::httpd_version}"],
                Package["httpd-devel-${httpd::config::httpd_version}"],
                Yumrepo['centos-base', 'centos-updates', 'centos-extras']
            ];
    }

    file {
        'httpd-vhosts':
            mode => 755,
            owner => 'root',
            group => 'root',
            path => '/etc/httpd/virtual_hosts/',
            ensure => directory,
            require => Package['httpd'];
        'httpd-vhosts-old':
            ensure => absent,
            path => "/etc/httpd/conf.d/*_vhost.conf",
            require => Package['httpd'];
        'httpd-cgi-bin-old':
            ensure => absent,
            path => "/var/www/cgi-bin",
            force => true,
            require => Package['httpd'];
        'httpd-error-old':
            ensure => absent,
            path => "/var/www/error",
            force => true,
            require => Package['httpd'];
        'httpd-icons-old':
            ensure => absent,
            path => "/var/www/icons",
            force => true,
            require => Package['httpd'];
        'httpd-readme':
            ensure => absent,
            path => "/etc/httpd/conf.d/README",
            require => Package['httpd'];
        'httpd-svn':
            ensure => absent,
            path => "/etc/httpd/conf.d/subversion.conf*",
            require => Package['httpd'];
        'httpd-welcome':
            ensure => absent,
            path => "/etc/httpd/conf.d/welcome.conf",
            require => Package['httpd'];
        'httpd-proxy_ajp-conf':
            mode => 644,
            owner => "root",
            group => "root",
            path => "/etc/httpd/conf.d/proxy_ajp.conf",
            content => template('httpd/conf.d/proxy_ajp.erb'),
            require => Package['httpd'];
        'httpd-conf':
            mode => 644,
            owner => "root",
            group => "root",
            path => "/etc/httpd/conf/httpd.conf",
            content => template('httpd/conf/httpd.erb'),
            require => Package['httpd'];
    }

    service {
        'httpd':
            ensure => true,
            enable => true,
            hasrestart => true,
            hasstatus => true,
            subscribe => [
                Package["httpd-tools-${httpd::config::httpd_version}"],
                Package["httpd-devel-${httpd::config::httpd_version}"],
                Package['httpd'],
                File['httpd-readme'],
                File['httpd-svn'],
                File['httpd-welcome'],
                File['httpd-proxy_ajp-conf'],
                File['httpd-conf'],
            ];
    }
}

define httpd::vhost (
    $directory,
    $ensure = 'present',
    $compress_output = true,
    $server_alias = []
){
    file{
        "${name}_vhost":
            mode => 644,
            owner => "root",
            group => "root",
            path => "/etc/httpd/virtual_hosts/${name}_vhost.conf",
            content => template("httpd/conf.d/vhost.erb"),
            notify => Service['httpd'],
            ensure => $ensure,
            require => Package['httpd'];
    }

    host {
        $name:
            ip => '127.0.0.1',
            ensure => $ensure,
            host_aliases => $server_alias,
            target => '/etc/hosts',
            require => Package['httpd'];
    }
}
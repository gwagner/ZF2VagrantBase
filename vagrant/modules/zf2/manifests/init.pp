class zf2
{
    include fedora, firewall, git, memcached, mysqld, nano, php-httpd, php::config, php::bcmath-extension,
        php::gd-extension, php::intl-extension, php::ldap-extension, php::mcrypt-extension,
        php::memcache-extension, php::mongo-extension, php::mysqlnd-extension, php::pear-extension,
        php::snmp-extension, php::soap-extension, php::xml-extension

    # Create an zf2 vhost
    httpd::vhost{
        'neufocus':
            directory => '/var/www/zf2/public',
            server_alias => ["www.neufocus.dev"];
    }

    #Notify memcached to be restarted if a change is made to the vhost
    File['neufocus_vhost'] ~> Service['memcached']

    file{

        'php-error-log':
            mode => 770,
            owner => 'apache',
            group => 'apache',
            path => '/var/log/php_errors',
            ensure => present;

        'php-session-dir':
            mode => 770,
            owner => 'apache',
            group => 'apache',
            path => '/var/lib/php/session',
            ensure => directory,
            require => [Package['php']];

        'httpd-php-conf':
            mode => 644,
            owner => "root",
            group => "root",
            path => "/etc/httpd/conf.d/php.conf",
            content => template('zf2/php.erb'),
            require => [Package['httpd'], Package['php']];

    }

    tidy {
        # Delete old tmp data that is more than 1 week old
        "/tmp/":
            age => "1w",
            recurse => true;

        # Drop any session that is over 1 month old
        "/var/lib/php/session":
            age => "4w",
            recurse => true;
    }



    # Make sure we trigger httpd for a restart when this extension is installed or changed
    Package["${php::config::php_prefix}-pecl-memcache-${php::config::memcached_version}"] ~> Service['httpd']

    # Make sure we trigger httpd for a restart when this extension is installed or changed
    Exec['/tmp/install-php-mongo.sh'] ~> Service['httpd']

    class {
        'php::composer':
            path => '/var/www/zf2/'
    }
}
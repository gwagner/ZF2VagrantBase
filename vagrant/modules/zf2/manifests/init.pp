class zf2
{
    include fedora, firewall, git, memcached, mysqld, nano, php-httpd, php::config,
        php::bcmath-extension, php::gd-extension, php::intl-extension, php::mcrypt-extension,
        php::memcached-extension, php::mongo-extension, php::mysqlnd-extension,
        php::pear-extension, php::xml-extension, php::zend-optimizer-extension

    user {
        'vagrant':
            membership => 'minimum',
            groups => ['apache','wheel'];
    }

    # Create an zf2 vhost
    httpd::vhost{
        'neufocus':
            directory => '/var/www/zf2/public',
            server_alias => ["www.neufocus.dev"],
            compress_output => false;
    }

    # Notify memcached to be restarted if a change is made to the vhost
    File['neufocus_vhost'] ~> Service['memcached']

    # Standard files used to run a PHP server
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

    # Clean out the tmp dir
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
    Package["php-ext-bcmath","php-ext-gd","php-ext-intl","php-ext-mcrypt",
        "php-ext-memcached","php-ext-mysqlnd","php-ext-pear","php-ext-xml"] ~> Service['httpd']

    Exec["php-ext-mongo","php-ext-zend-optimizer"] ~> Service['httpd']

    File['zend-optimizer-extension-ini', 'mongo-extension-ini'] ~> Service['httpd']

    # Run composer to pull down ZF2 libraries
    class {
        'php::composer':
            path => '/var/www/zf2/'
    }

    # Make sure port 80 is open
    iptables::allow {
        'tcp/80': port => '80', protocol => 'tcp';
    }
}
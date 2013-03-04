class php::mongo-extension
{
    include php::config

    file{
        'install-php-mongo.sh':
            mode => 744,
            owner => "root",
            group => "root",
            path => "/tmp/install-php-mongo.sh",
            content => template('php/install-php-mongo.erb'),
            require => [
                Package["${php::config::php_prefix}-common-${php::config::php_version}"]
            ];
        'mongo-package':
            mode => 744,
            owner => "root",
            group => "root",
            path => "/tmp/mongo-php-driver-${php::config::mongo_version}.tar.gz",
            source => "puppet:///modules/php/mongo-php-driver-${php::config::mongo_version}.tar.gz",
            require => [
                Package["${php::config::php_prefix}-common-${php::config::php_version}"]
            ];
        'mongo-extension-ini':
            mode => 644,
            owner => "root",
            group => "root",
            path => "/etc/php.d/mongo.ini",
            content => template('php/mongo-extension-ini.erb'),
            require => [
                Package["${php::config::php_prefix}-common-${php::config::php_version}"]
            ];
    }

    exec{
        '/tmp/install-php-mongo.sh':
            user => 'root',
            creates => "${script_run_lock}mongo-${php::config::mongo_version}",
            require => [
                File['install-php-mongo.sh'],
                File['mongo-package'],
                Package["${php::config::php_prefix}-common-${php::config::php_version}"],
                Package["${php::config::php_prefix}-devel-${php::config::php_version}"]
            ]
    }
}
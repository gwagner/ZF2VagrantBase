class php::mongo-extension
{
    include php::config

    file{
        'install-php-mongo.sh':
            mode => 744,
            owner => "root",
            group => "root",
            path => "/tmp/install-php-mongo.sh",
            content => template('php/install-php-mongo.erb');
        'mongo-package':
            mode => 744,
            owner => "root",
            group => "root",
            path => "/tmp/mongo-php-driver-${php::config::mongo_version}.tar.gz",
            source => "puppet:///modules/php/mongo-php-driver-${php::config::mongo_version}.tar.gz",
            notify => Exec['php-ext-mongo'];
        'mongo-extension-ini':
            mode => 644,
            owner => "root",
            group => "root",
            path => "/etc/php.d/mongo.ini",
            content => template('php/mongo-extension-ini.erb');
    }

    exec{
        'php-ext-mongo':
            command => '/tmp/install-php-mongo.sh',
            user => 'root',
            creates => "/usr/lib64/php/modules/mongo.so",
            require => [
                File['install-php-mongo.sh'],
                File['mongo-package'],
                $php::config::extension_dependencies
            ];
    }
}
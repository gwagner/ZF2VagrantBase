class php::zend-optimizer-extension
{
    include php::config

    file{
        'install-php-zend-optimizer.sh':
            mode => 744,
            owner => "root",
            group => "root",
            path => "/tmp/install-php-zend-optimizer.sh",
            content => template('php/install-php-zend-optimizer.erb'),
            require => [
                Package["${php::config::php_prefix}-common-${php::config::php_version}"]
            ];
        'zend-optimizer-package':
            mode => 744,
            owner => "root",
            group => "root",
            path => "/tmp/zend-optimizer-package.tar.gz",
            source => "puppet:///modules/php/ZendOptimizerPlus-master.tar.gz",
            notify => Exec['php-ext-zend-optimizer'];
        'zend-optimizer-extension-ini':
            mode => 644,
            owner => "root",
            group => "root",
            path => "/etc/php.d/zend-optimizer.ini",
            content => template('php/zend-optimizer-extension-ini.erb'),
            require => File['/etc/php.d'];
    }

    exec{
        'php-ext-zend-optimizer':
            command => '/tmp/install-php-zend-optimizer.sh',
            user => 'root',
            creates => "/usr/lib64/php/modules/ZendOptimizerPlus.so",
            require => [
                File['install-php-zend-optimizer.sh'],
                File['zend-optimizer-package'],
                $php::config::extension_dependencies
            ];
    }
}
class php-httpd
{
    include php, php::config, httpd, httpd::config

    # install the package that links PHP to Apache
    package{
        "${php::config::php_prefix}-${php::config::php_version}":
            ensure => installed,
            provider => 'yum',
            require => [
                Yumrepo['ius'],
                Package['re2c'],
                Package['gcc'],
                Package["${php::config::php_prefix}-common-${php::config::php_version}"],
                Package["${php::config::php_prefix}-cli-${php::config::php_version}"]
            ],
            alias => 'php',
            notify => Service['httpd'];
    }

    # Make sure that any change to PHP common restarts Apache
    Package["${php::config::php_prefix}-common-${php::config::php_version}"] ~> Service['httpd']
}
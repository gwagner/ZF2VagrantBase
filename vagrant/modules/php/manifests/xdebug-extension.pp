class php::xcache-extension
{
    require php::config, php::pear-extension, repo-ius

    package {
        "${php::config::php_prefix}-xdebug-${php::config::php_xdebug_version}":
            ensure => installed,
            provider => 'yum',
            require => [
                Yumrepo['ius'],
                Package['re2c'],
                Package['gcc'],
                Package["php-common"],
                Package["php-cli"],
                Package["${php::config::php_prefix}-pear-${php::config::php_pear_version}"]
            ];

    }
}
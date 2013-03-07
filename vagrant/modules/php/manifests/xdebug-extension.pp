class php::xcache-extension
{
    require php::config, php::pear-extension, repo_ius

    package {
        'php-ext-xdebug':
            name => "${php::config::php_prefix}-xdebug-${php::config::php_xdebug_version}",
            ensure => installed,
            provider => 'yum',
            require => [
                $php::config::extension_dependencies,
                Package["${php::config::php_prefix}-pear-${php::config::php_pear_version}"]
            ];

    }
}
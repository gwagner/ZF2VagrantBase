class php::xcache-extension
{
    require php::config, repo_ius

    package {
        'php-ext-xcache':
            name => "${php::config::php_prefix}-xcache-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;
    }
}
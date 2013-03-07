class php::soap-extension
{
    require php::config, repo_ius

    package {
        'php-ext-soap':
            name => "${php::config::php_prefix}-soap-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;
    }
}
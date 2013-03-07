class php::ioncube-loader-extension
{
    require php::config, repo_ius

    package {
        'php-ext-ioncube':
            name => "${php::config::php_prefix}-ioncube-loader-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}
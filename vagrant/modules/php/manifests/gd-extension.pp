class php::gd-extension
{
    require php::config, repo_ius

    package {
        'php-ext-gd':
            name => "${php::config::php_prefix}-gd-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}
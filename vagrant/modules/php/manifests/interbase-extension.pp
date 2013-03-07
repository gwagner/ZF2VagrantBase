class php::interbase-extension
{
    require php::config, repo_ius

    package {
        'php-ext-interbase':
            name => "${php::config::php_prefix}-interbase-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}
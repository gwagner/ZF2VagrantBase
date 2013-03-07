class php::pgsql-extension
{
    require php::config, repo_ius

    package {
        'php-ext-pgsql':
            name => "${php::config::php_prefix}-pgsql-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}
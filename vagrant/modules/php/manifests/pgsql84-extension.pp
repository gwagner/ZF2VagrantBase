class php::pgsql84-extension
{
    require php::config, repo_ius

    package {
        'php-ext-pgsql84':
            name => "${php::config::php_prefix}-pgsql84-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}
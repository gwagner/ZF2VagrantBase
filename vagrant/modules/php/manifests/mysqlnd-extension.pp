class php::mysqlnd-extension
{
    require php::config, repo_ius

    package {
        'php-ext-mysqlnd':
            name => "${php::config::php_prefix}-mysqlnd-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}
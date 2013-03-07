class php::mssql-extension
{
    require php::config, repo_ius

    package {
        'php-ext-mssql':
            name => "${php::config::php_prefix}-mssql-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}
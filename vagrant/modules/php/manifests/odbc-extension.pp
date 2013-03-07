class php::odbc-extension
{
    require php::config, repo_ius

    package {
        'php-ext-odbc':
            name => "${php::config::php_prefix}-odbc-${php::config::php_version}",
            ensure => installed,
            provider => 'yum',
            require => $php::config::extension_dependencies;

    }
}